import 'package:flutter/material.dart';
import 'package:wowsinfo/models/gamedata/ship.dart';
import 'package:wowsinfo/repositories/game_repository.dart';

class SimilarShipProvider extends ChangeNotifier {
  final Ship _ship;
  SimilarShipProvider(this._ship);

  bool get hasSimilarShips => _similarShips.isNotEmpty;
  List<Ship> get similarShips => _similarShips;

  late final _similarShips = _getSimilarShips();
  List<Ship> _getSimilarShips() {
    final ships = GameRepository.instance.shipList;
    // same tier, same region, same group
    return ships
        .where((ship) =>
            ship.id != _ship.id &&
            ship.type == _ship.type &&
            ship.tier == _ship.tier &&
            ship.isSpecialGroup == _ship.isSpecialGroup)
        .toList();
  }
}
