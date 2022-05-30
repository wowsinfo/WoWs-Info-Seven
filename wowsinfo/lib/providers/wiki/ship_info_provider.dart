import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:wowsinfo/extensions/number.dart';
import 'package:wowsinfo/models/gamedata/game_info.dart';
import 'package:wowsinfo/models/gamedata/ship.dart';
import 'package:wowsinfo/models/wowsinfo/ammo_shells.dart';
import 'package:wowsinfo/models/wowsinfo/ship_module_selection.dart';
import 'package:wowsinfo/models/wowsinfo/ship_modules.dart';
import 'package:wowsinfo/repositories/game_repository.dart';
import 'package:wowsinfo/repositories/localisation.dart';

/// For the individual ship information.
class ShipInfoProvider with ChangeNotifier {
  final _logger = Logger('ShipInfoProvider');

  final BuildContext _context;
  final Ship _ship;
  late final _shipModules = ShipModules(_ship);
  ShipInfoProvider(this._context, this._ship) {
    _shipModules.unpackModules();
  }

  ShipModuleSelection get selection => _shipModules.selection;
  void updateSelection(ShipModuleSelection selection) {
    _shipModules.updateSelection(selection);
    _logger.fine('Updated ship module selection');
    notifyListeners();
  }

  String _percent(num? value) {
    if (value == null) return '-';
    return '${value.toDecimalString()}%';
  }

  String _format(num? value) {
    if (value == null) return '-';
    return value.toDecimalString();
  }

  /// This is to calculate the maximum or minimum value
  /// TODO: to be removed in 2.0 because it will be dynamic instead
  String _calc(num? value, double factor) {
    if (value == null) return '-';
    final calculated = (value * factor).toDecimalString();
    return '${value.toDecimalString()} - $calculated';
  }

  String _calcAdd(num? value, double offset) {
    if (value == null) return '-';
    final calculated = (value + offset).toDecimalString();
    return '${value.toDecimalString()} - $calculated';
  }

  String get title => '$shipIcon ${_ship.id}';
  String get tier => GameInfo.tiers[_ship.tier - 1];

  String get shipName => Localisation.instance.stringOf(_ship.name) ?? '-';
  String get shipIcon => _ship.index;
  String get description =>
      Localisation.instance.stringOf(_ship.description) ?? '-';
  String get type => Localisation.instance.stringOf(_ship.typeId) ?? '-';
  String get region => Localisation.instance.stringOf(_ship.regionId) ?? '-';
  String? get costCR => _ship.costCr > 0 ? _format(_ship.costCr) : null;
  String? get costGold => _ship.costGold > 0 ? _format(_ship.costGold) : null;

  late final bool canChangeModules = _shipModules.canChangeModules;
  late final ShipModuleMap moduleList = _shipModules.moduleList;

  HullInfo? get _hullInfo => _shipModules.hullInfo?.data;
  bool get renderHull => _hullInfo != null;
  String get health => _format(_hullInfo?.health);
  String get torpedoProtection => _percent(_hullInfo?.protection);

  GunInfo? get _mainGunInfo => _shipModules.gunInfo?.data;
  bool get renderMainGun => _mainGunInfo != null;
  WeaponInfo? get _gun => _mainGunInfo?.guns.first;
  String get gunReloadTime => '${_format(_gun?.reload)} s';
  String get gunRange => '${_format(_mainGunInfo?.range)} km';
  String get gunRotationTime => '${_format(_gun?.rotation)} s';
  String get gunName =>
      Localisation.instance.stringOf(_shipModules.gunInfo?.module?.name) ?? '-';

  List<Shell> shells = [];
  List<Shell> _extractShells(GunInfo? gunInfo) {
    if (gunInfo == null) return [];
    final List<Shell> shells = [];
    final gun = gunInfo.guns.first;
    for (final ammo in gun.ammo) {
      final ammoInfo = GameRepository.instance.projectileOf(ammo);
      if (ammoInfo == null) continue;

      switch (ammoInfo.type) {
        case 'HE':
          ammoInfo.burnChance;
          break;
        case 'AP':
          break;
        case 'SAP':
          break;
        default:
          _logger.warning('Unknown ammo type: ${ammoInfo.type}');
      }
    }
    return shells;
  }

  TorpedoInfo? get _torpedoInfo => _shipModules.torpedoInfo?.data;
  bool get renderTorpedo => _torpedoInfo != null;
  String get torpedoName =>
      Localisation.instance
          .stringOf('IDS_${_torpedoInfo?.launchers[0].ammo[0]}') ??
      '';
}
