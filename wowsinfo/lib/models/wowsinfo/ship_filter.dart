import 'package:logging/logging.dart';
import 'package:wowsinfo/repositories/localisation.dart';

enum _ShipFilterKey { nation, shipname, shiptype, level }

/// An interface for filtering ships with a [ShipFilter]
abstract class ShipFilterInterface {
  String get name;
  int get tier;
  String get region;
  String get type;
}

/// Filter ships with conditions
class ShipFilter {
  // empty lists are not allowed
  ShipFilter({
    required this.name,
    required this.tiers,
    required this.regions,
    required this.types,
  });

  final _logger = Logger('ShipFilter');
  final String name;
  final List<int> tiers;
  final List<String> regions;
  final List<String> types;

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
    final name = Localisation.instance.stringOf(keyName);
    if (name == null) {
      _logger.severe('$keyName is invalid!');
      throw Exception('Failed to get filter name: $keyName');
    }

    return name;
  }

  bool get isEmpty {
    return name.trim().isEmpty &&
        tiers.isEmpty &&
        regions.isEmpty &&
        types.isEmpty;
  }

  /// Check if this ship should be displayed
  bool shouldDisplay(ShipFilterInterface ship) {
    if (name.trim().isNotEmpty) {
      // [ship.name] is the key not the actual string
      final shipName = Localisation.instance.stringOf(ship.name);
      if (shipName == null) {
        _logger.severe('${ship.name} is invalid!');
        throw Exception('Failed to get ship name: ${ship.name}');
      }

      if (!shipName.toLowerCase().contains(name.toLowerCase())) {
        return false;
      }
    }

    if (tiers.isNotEmpty && tiers.contains(ship.tier) == false) {
      return false;
    }
    if (regions.isNotEmpty && regions.contains(ship.region) == false) {
      return false;
    }
    if (types.isNotEmpty && types.contains(ship.type) == false) {
      return false;
    }

    return true;
  }

  @override
  String toString() {
    return 'ShipFilter{shipName: $name, tierList: $tiers, regionList: $regions, typeList: $types}';
  }
}
