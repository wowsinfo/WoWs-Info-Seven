import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:wowsinfo/models/gamedata/game_info.dart';
import 'package:wowsinfo/models/wowsinfo/ship_filter.dart';
import 'package:wowsinfo/repositories/game_repository.dart';
import 'package:wowsinfo/repositories/localisation.dart';

/// Provides data and handle logic for `showFilterShipDialog`
class FilterShipProvider with ChangeNotifier {
  final _regions = GameRepository.instance.shipRegionList;
  final _types = GameRepository.instance.shipTypeList;
  final _logger = Logger('FilterShipProvider');

  BuildContext _context;
  FilterShipProvider(this._context);

  // selected filters
  var _selectedRegion = <int>{};
  var _selectedType = <int>{};
  var _selectedTier = <int>{};

  String _getStringOf(String key) {
    final name = Localisation.instance.stringOf(key, prefix: 'IDS_');

    if (name == null) {
      _logger.severe('$key is invalid!');
      throw Exception('Failed to get filter name: $key');
    }

    return name;
  }

  // generate region lists for UI
  late final regionList =
      _regions.map((r) => _getStringOf(r)).toList(growable: false);
  late final typeList =
      _types.map((t) => _getStringOf(t)).toList(growable: false);
  final tierList = GameInfo.tiers;

  bool isRegionSelected(int index) => _selectedRegion.contains(index);
  bool isTypeSelected(int index) => _selectedType.contains(index);
  bool isTierSelected(int index) => _selectedTier.contains(index);

  String get regionFilterName {
    final name = Localisation.instance.regionFilterName;
    return '$name (${Localisation.of(_context).region})';
  }

  void updateRegion(String key) {
    final index = regionList.indexOf(key);
    if (_selectedRegion.contains(index)) {
      _selectedRegion.remove(index);
      _logger.fine('$key is removed from region list');
    } else {
      _selectedRegion.add(index);
      _logger.fine('$key is added to region list');
    }
    _selectedRegion = _selectedRegion;
    notifyListeners();
  }

  void updateType(String key) {
    final index = typeList.indexOf(key);
    if (_selectedType.contains(index)) {
      _selectedType.remove(index);
      _logger.fine('$key is removed from type list');
    } else {
      _selectedType.add(index);
      _logger.fine('$key is added to type list');
    }
    _selectedType = _selectedType;
    notifyListeners();
  }

  void updateTier(String key) {
    final index = GameInfo.tiers.indexOf(key);
    if (_selectedTier.contains(index)) {
      _selectedTier.remove(index);
      _logger.fine('$key is removed from tier list');
    } else {
      _selectedTier.add(index);
      _logger.fine('$key is added to tier list');
    }
    _selectedTier = _selectedTier;
    notifyListeners();
  }

  void resetAll() {
    _selectedRegion.clear();
    _selectedType.clear();
    _selectedTier.clear();
    notifyListeners();
  }

  ShipFilter onFilter(String name) {
    final tiers = _selectedTier.map((e) => e + 1).toList();
    final types = _selectedType.map((e) => _types[e]).toList();
    final regions = _selectedRegion.map((e) => _regions[e]).toList();

    return ShipFilter(name: name, tiers: tiers, regions: regions, types: types);
  }
}
