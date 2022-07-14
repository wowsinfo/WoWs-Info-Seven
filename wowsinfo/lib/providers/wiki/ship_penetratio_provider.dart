import 'package:charts_flutter/flutter.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:wowsinfo/foundation/helpers/chart_utils.dart';
import 'package:wowsinfo/models/gamedata/projectile.dart';
import 'package:wowsinfo/models/gamedata/ship.dart';
import 'package:wowsinfo/models/wowsinfo/ap_penetration.dart';
import 'package:wowsinfo/models/wowsinfo/ship_modules.dart';
import 'package:wowsinfo/repositories/game_repository.dart';

/// This is a fixed value if a secondary axis is needed
const _secondaryMeasureAxisId = 'secondaryMeasureAxisId';

class ShipPenetrationProvider {
  final _logger = Logger('ShipPenetrationProvider');
  final BuildContext _context;
  final Ship _ship;
  late final _shipModules = ShipModules(_ship);
  ShipPenetrationProvider(this._context, this._ship) {
    // TODO: how to possibily get ship main gun info without doing the full unpacking???
    _shipModules.unpackModules();
    _mainGunInfo = _shipModules.gunInfo?.data;
  }

  GunInfo? _mainGunInfo;

  late ApPenetrationInfo? _penInfo = _getCurrentPenetration();
  ApPenetrationInfo? _getCurrentPenetration() {
    // get the projectile
    final gun = _mainGunInfo?.guns.first;
    if (gun == null) return null;

    ArmorPiecingInfo? apInfo;
    Projectile? ap;
    for (final ammo in gun.ammo) {
      final ammoInfo = GameRepository.instance.projectileOf(ammo);
      if (ammoInfo == null) continue;

      if (ammoInfo.ammoType != 'AP') continue;
      _logger.info(ammoInfo.ammoType);
      ap = ammoInfo;
      apInfo = ap.ap;
      break;
    }

    if (ap == null) return null;
    if (apInfo == null) return null;

    // TODO: angle shouldn't be fixed here
    return ApPenetration(
      info: apInfo,
      range: _mainGunInfo?.range.toDouble() ?? 0.0,
      verticalAngle: 40,
    ).calculatePenetration();
  }

  // provide the series data
  List<Series<ChartValue, int>> get penetrationSeries => _penetrationSeries;
  late List<Series<ChartValue, int>> _penetrationSeries =
      _getPenetrationSeries();
  List<Series<ChartValue, int>> _getPenetrationSeries() {
    final penInfo = _penInfo;
    if (penInfo == null) return [];
    final penValues = penInfo.penetration;
    final penDists = penInfo.distance;
    final shellTime = penInfo.time;

    final List<ChartValue<int, double>> pValues = [];
    final List<ChartValue<int, double>> tValues = [];
    for (var i = 0; i < penValues.length; i++) {
      pValues.add(ChartValue(
        penDists[i].toInt(),
        penValues[i],
      ));

      tValues.add(ChartValue(
        penDists[i].toInt(),
        shellTime[i],
      ));
    }

    // TODO: add the proper name
    final penSeries = ChartUtils.convertDefault(
      'penetration',
      values: pValues,
      color: ChartUtils.damageColour,
      labelFormatter: (value, index) => value.name.toString(),
    );

    final timeSeries = ChartUtils.convertDefault(
      'time',
      values: tValues,
      color: ChartUtils.winrateColour,
      labelFormatter: (value, index) => value.name.toString(),
    )..setAttribute(measureAxisIdKey, _secondaryMeasureAxisId); // a fixed key

    return [penSeries, timeSeries];
  }

  // customise the penetration axis
  NumericTickProviderSpec? buildPenetrationSpec(int count) {
    _logger.info('buildPenetrationSpec: $count');
    final penList = _penInfo?.penetration;
    if (penList == null) return null;
    // round min and max to nearest 10
    final minimum = (penList.last / 10).round() * 10;
    final maximum = (penList.first / 10).round() * 10;

    final segment = (maximum - minimum) / count;
    _logger.fine('segment: $segment, minimum: $minimum, maximum: $maximum');
    if (segment <= 0) return null;

    return StaticNumericTickProviderSpec(
      List.generate(
        count + 2, // so that it covers up the max value
        (index) => TickSpec(
          minimum + segment * index,
        ),
      ),
    );
  }

  /// The domain (distance) spec is based on the device with
  NumericTickProviderSpec? buildDistanceSpec() {
    final deviceWidth = MediaQuery.of(_context).size.width;
    _logger.info('deviceWidth: $deviceWidth');
    // only needed for smaller screens
    if (deviceWidth > 900) return null;
    final distanceList = _penInfo?.distance;
    if (distanceList == null) return null;
    const minimum = 0;
    final maximum = distanceList.last;
    final count = (deviceWidth / 120).round();
    _logger.info('count $count, minimum $minimum, maximum $maximum');
    final segment =
        (((maximum - minimum) / count) / 1000).roundToDouble() * 1000;
    _logger.info('segment $segment');

    return StaticNumericTickProviderSpec(
      List.generate(
        count + 1, // so that it covers up the max value
        (index) => TickSpec(
          (minimum + segment * index).roundToDouble(),
        ),
      ),
    );
  }

  Color getThemePalette() {
    final theme = Theme.of(_context);
    return theme.brightness == Brightness.light
        ? MaterialPalette.black
        : MaterialPalette.white;
  }
}
