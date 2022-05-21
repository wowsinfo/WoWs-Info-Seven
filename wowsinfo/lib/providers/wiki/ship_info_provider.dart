import 'package:flutter/foundation.dart';
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
}
