import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:wowsinfo/extensions/number.dart';
import 'package:wowsinfo/models/gamedata/game_info.dart';
import 'package:wowsinfo/models/gamedata/ship.dart';
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
    // some might be 0.35 instead of 35.0
    if (value < 1) return '${(value * 100).toDecimalString()}%';
    return '${value.toDecimalString()}%';
  }

  String _format(num? value, {String suffix = ''}) {
    if (value == null) return '-';
    return '${value.toDecimalString()} $suffix';
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
  String get gunReloadTime => _format(_gun?.reload, suffix: 's');
  // Consider the fire control system here
  String get gunRange {
    final suo = _shipModules.fireControlInfo;
    final range = _mainGunInfo?.range;
    if (range == null) return '-';
    if (suo == null) return _format(range / 1000, suffix: 'km');
    // increase the range
    final improvedRange = range * suo.data.maxDistCoef;
    return _format(improvedRange / 1000, suffix: 'km');
  }

  // Group guns together and format like 3 x 2 1 x 3 (9)
  String get gunConfiguration {
    final guns = _mainGunInfo?.guns;
    if (guns == null) return '-';

    List<String> config = [];
    // int total = 0;
    for (final gun in guns) {
      config.add('${gun.each} x ${gun.count}');
      // total += gun.each * gun.count;
    }

    if (config.isEmpty) return '-';
    return config.join(' ');
  }

  String get gunRotationTime => _format(_gun?.rotation, suffix: 's');
  String get gunName =>
      Localisation.instance.stringOf(_shipModules.gunInfo?.module?.name) ?? '-';

  List<ShellHolder> get shells => _extractShells(_mainGunInfo);
  List<ShellHolder> _extractShells(GunInfo? gunInfo) {
    if (gunInfo == null) return [];
    final List<ShellHolder> shells = [];
    final gun = gunInfo.guns.first;
    for (final ammo in gun.ammo) {
      final ammoInfo = GameRepository.instance.projectileOf(ammo);
      if (ammoInfo == null) continue;

      _logger.fine('Found ammo: ${ammoInfo.name}');
      final type = ammoInfo.ammoType;
      if (type == null) continue;

      final shell = ShellHolder(name: type);
      switch (ammoInfo.ammoType) {
        case 'HE':
          shell.burnChance = _percent(ammoInfo.burnChance);
          shell.damage = _format(ammoInfo.damage);
          shell.penetration = _format(ammoInfo.penHe, suffix: 'mm');
          shell.velocity = _format(ammoInfo.speed, suffix: 'm/s');
          break;
        case 'AP':
          shell.burnChance = _percent(ammoInfo.burnChance);
          shell.damage = _format(ammoInfo.damage);
          shell.overmatch = _format(ammoInfo.overmatch, suffix: 'mm');
          shell.velocity = _format(ammoInfo.speed, suffix: 'm/s');
          break;
        case 'CS':
          shell.burnChance = _percent(ammoInfo.burnChance);
          shell.damage = _format(ammoInfo.damage);
          shell.penetration = _format(ammoInfo.penSAP, suffix: 'mm');
          shell.velocity = _format(ammoInfo.speed, suffix: 'm/s');
          break;
        default:
          _logger.severe('Unknown ammo type: ${ammoInfo.type}');
          continue;
      }
      shells.add(shell);
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

/// This model is used to hold the shell information
class ShellHolder {
  ShellHolder({
    required this.name,
  });

  final String name;
  String? burnChance;
  String? weight;
  String? velocity;
  String? damage;
  String? penetration;
  String? overmatch;
}
