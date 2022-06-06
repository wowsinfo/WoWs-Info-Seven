import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:wowsinfo/models/gamedata/ship.dart';
import 'package:wowsinfo/models/wowsinfo/ship_filter.dart';
import 'package:wowsinfo/repositories/game_repository.dart';
import 'package:wowsinfo/widgets/shared/filter_ship_dialog.dart';

/// Provides the entire ship list and filter it with the given [ShipFilter]
class ShipProvider with ChangeNotifier {
  final BuildContext _context;
  final bool _special;
  ShipProvider(this._context, this._special);

  late final _ships = GameRepository.instance.shipList.where((ship) {
    return ship.isSpecialGroup == _special;
  }).toList();
  final _logger = Logger('ShipProvider');
  List<Ship>? _filteredShips;

  List<Ship> get shipList => _filteredShips ?? _ships;
  int get shipCount => shipList.length;
  String get filterString => '-  $shipCount';

  void resetFilter() {
    _filteredShips = null;
    notifyListeners();
  }

  void showFilter() {
    showFilterShipDialog(_context, (filter) {
      _logger.fine('Filter: $filter');
      if (filter.isEmpty) {
        _filteredShips = _ships;
      } else {
        _filteredShips =
            _ships.where((ship) => filter.shouldDisplay(ship)).toList();
      }

      notifyListeners();
    });
  }
}
