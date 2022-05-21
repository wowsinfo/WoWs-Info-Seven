import 'package:flutter/material.dart';
import 'package:wowsinfo/models/gamedata/game_info.dart';
import 'package:wowsinfo/models/gamedata/ship.dart';
import 'package:wowsinfo/repositories/game_repository.dart';

/// For the individual ship information.
class ShipInfoProvider with ChangeNotifier {
  final BuildContext _context;
  final Ship _ship;
  ShipInfoProvider(this._context, this._ship);

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

  final List<HullInfo> _hullInfo = [];

  void _unpackShipModules() {
    for (final module in _ship.modules.entries) {
      final moduleType = module.key;
      final modules = module.value;
      switch (moduleType) {
        case '_Hull':
          break;
        case '_Artillery':
          break;
        case '_Torpedoes':
          break;
        case '_Suo':
          break;
        case '_Engine':
          break;
        case '_SkipBomber':
        case '_TorpedoBomber':
        case '_DiveBomber':
        case '_Fighter':
          // this contains a key to an Aircraft
          break;
        case '_Sonar':
        case '_Abilities':
        case '_SecondaryWeapons':
        case '_PrimaryWeapons':
        case '_FlightControl':
          // ignore these for now
          break;
        default:
          // we don't need to use everything but we should know about it
          throw UnimplementedError('Unknown module - $moduleType');
      }
    }
  }
}
