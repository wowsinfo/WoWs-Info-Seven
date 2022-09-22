import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart';
import 'package:wowsinfo/models/wowsinfo/ship_filter.dart';
import 'package:wowsinfo/providers/wiki/ship_info_provider.dart';
import 'package:wowsinfo/repositories/game_repository.dart';

class CompareShipProvider with ChangeNotifier {
  final _logger = Logger('CompareShipProvider');

  ShipFilter? _filter;
  set filter(ShipFilter value) {
    if (_filter == value) return;
    _compareShip(value);
  }

  Iterable<ShipInfoProvider> _ships = [];
  Iterable<ShipInfoProvider> get ships => _ships;

  void _compareShip(ShipFilter filter) {
    _filter = filter;
    final ships = GameRepository.instance.shipList;
    _ships = ships
        .where((s) => filter.shouldDisplay(s))
        .map((s) => ShipInfoProvider(s));
    _logger.info('CompareShipProvider updated with ${_ships.length} ships');

    notifyListeners();
  }
}
