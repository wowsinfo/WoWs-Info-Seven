import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:wowsinfo/models/gamedata/game_info.dart';
import 'package:wowsinfo/models/gamedata/ship.dart';
import 'package:wowsinfo/models/wowsinfo/ship_module_selection.dart';
import 'package:wowsinfo/models/wowsinfo/ship_modules.dart';
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

  // TODO: some should be final instead of a getter
  String get shipName => Localisation.instance.stringOf(_ship.name) ?? '';
  String get shipIcon => _ship.index;
  String get title => '$shipIcon ${_ship.id}';
  String get description =>
      Localisation.instance.stringOf(_ship.description) ?? '';
  String get type => Localisation.instance.stringOf(_ship.typeId) ?? '';
  String get tier => GameInfo.tiers[_ship.tier - 1];
  String get region => Localisation.instance.stringOf(_ship.regionId) ?? '';
  String? get costCR => _ship.costCr > 0 ? '${_ship.costCr}' : null;
  String? get costGold => _ship.costGold > 0 ? '${_ship.costGold}' : null;

  late final bool canChangeModules = _shipModules.canChangeModules;
  late final ShipModuleMap moduleList = _shipModules.moduleList;

  HullInfo? get _hullInfo => _shipModules.hullInfo;
  bool get renderHull => _hullInfo != null;
  String get health => _hullInfo?.health.toStringAsFixed(0) ?? '0';
  String get torpedoProtection =>
      _hullInfo?.protection?.toStringAsFixed(0) ?? '0%';

  GunInfo? get _mainGunInfo => _shipModules.gunInfo;
  bool get renderMainGun => _mainGunInfo != null;

  TorpedoInfo? get _torpedoInfo => _shipModules.torpedoInfo;
  bool get renderTorpedo => _torpedoInfo != null;
  String get torpedoName =>
      Localisation.instance
          .stringOf('IDS_${_torpedoInfo?.launchers[0].ammo[0]}') ??
      '';
}
