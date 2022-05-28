import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:wowsinfo/models/gamedata/game_info.dart';
import 'package:wowsinfo/models/gamedata/ship.dart';
import 'package:wowsinfo/models/wowsinfo/ship_module_selection.dart';
import 'package:wowsinfo/models/wowsinfo/ship_modules.dart';
import 'package:wowsinfo/repositories/game_repository.dart';

/// For the individual ship information.
class ShipInfoProvider with ChangeNotifier {
  final _logger = Logger('ShipInfoProvider');

  final BuildContext _context;
  final Ship _ship;
  late final _shipModules = ShipModules(_ship, notifyChanges: _onChange);
  ShipInfoProvider(this._context, this._ship) {
    _shipModules.unpackModules();
  }

  void _onChange() => notifyListeners();

  ShipModuleSelection get selection => _shipModules.selection;

  // TODO: some should be final instead of a getter
  String get shipName => GameRepository.instance.stringOf(_ship.name) ?? '';
  String get shipIcon => _ship.index;
  String get title => '$shipIcon ${_ship.id}';
  String get description =>
      GameRepository.instance.stringOf(_ship.description) ?? '';
  String get type => GameRepository.instance.stringOf(_ship.typeId) ?? '';
  String get tier => GameInfo.tiers[_ship.tier - 1];
  String get region => GameRepository.instance.stringOf(_ship.regionId) ?? '';
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
}
