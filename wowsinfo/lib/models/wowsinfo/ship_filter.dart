import 'package:logging/logging.dart';
import 'package:wowsinfo/models/gamedata/ship.dart';
import 'package:wowsinfo/repositories/game_repository.dart';

enum _ShipFilterKey { nation, shipname, shiptype, level }

/// Filter ships with conditions
class ShipFilter {
  // empty lists are not allowed
  ShipFilter(
    this.shipName,
    this.tierList,
    this.regionList,
    this.typeList,
  );

  final _logger = Logger('ShipFilter');
  final String shipName;
  final List<int> tierList;
  final List<String> regionList;
  final List<String> typeList;

  /// TODO: who should handle all these string keys??
  /// TODO: maybe we need a language class to handle all these strings
  final _ids = 'IDS_CAROUSEL_APPLIED_FILTER_HINT_';
  // filter names
  late final regionFilterName = _getFilterName(_ShipFilterKey.nation);
  late final shipNameFilterName = _getFilterName(_ShipFilterKey.shipname);
  late final shipTypeFilterName = _getFilterName(_ShipFilterKey.shiptype);
  late final tierFilterName = _getFilterName(_ShipFilterKey.level);

  String _getFilterName(_ShipFilterKey key) {
    final keyName = _ids + key.name.toUpperCase();
    final name = GameRepository.instance.stringOf(keyName);
    if (name == null) {
      _logger.severe('$keyName is invalid!');
      throw Exception('Failed to get filter name: $keyName');
    }

    return name;
  }

  /// Check if this ship should be displayed
  bool shouldDisplay(Ship ship) {
    if (shipName.trim().isNotEmpty && ship.name.contains(shipName) == false) {
      return false;
    }

    if (tierList.isNotEmpty && tierList.contains(ship.tier) == false) {
      return false;
    }
    if (regionList.isNotEmpty && regionList.contains(ship.region) == false) {
      return false;
    }
    if (typeList.isNotEmpty && typeList.contains(ship.type) == false) {
      return false;
    }

    _logger.fine('Ship ${ship.index} should be displayed');
    return true;
  }
}
