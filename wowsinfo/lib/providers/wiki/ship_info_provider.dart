import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:wowsinfo/models/gamedata/ship.dart';
import 'package:wowsinfo/repositories/game_repository.dart';

/// For the individual ship information.
class ShipInfoProvider with ChangeNotifier {
  final BuildContext _context;
  final Ship _ship;
  ShipInfoProvider(this._context, this._ship);

  String get shipName => GameRepository.instance.stringOf(_ship.name) ?? '';
  String get shipIcon => _ship.index;
}
