import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart';
import 'package:wowsinfo/models/gamedata/game_info.dart';
import 'package:wowsinfo/models/wowsinfo/ship_filter.dart';
import 'package:wowsinfo/repositories/game_repository.dart';

/// Provides data and handle logic for `showFilterShipDialog`
class FilterShipProvider with ChangeNotifier {
  final _regions = GameRepository.instance.shipRegionList;
  final _types = GameRepository.instance.shipTypeList;
  final _logger = Logger('FilterShipProvider');

  late Map<String, bool> _regionMap = _makeMap(_regions);
  late Map<String, bool> _typeMap = _makeMap(_types);
  late Map<String, bool> _tierMap = {
    for (final tier in GameInfo.tiers) tier: false
  };

  Map<String, bool> _makeMap(List<String> list) {
    return {for (var e in list.map((e) => _getStringOf(e))) e: false};
  }

  String _getStringOf(String key) {
    final name = GameRepository.instance.stringOf(key, prefix: 'IDS_');

    if (name == null) {
      _logger.severe('$key is invalid!');
      throw Exception('Failed to get filter name: $key');
    }

    return name;
  }

  List<String> get regionList => _regionMap.keys.toList();
  List<bool> get regionSelectedList => _regionMap.values.toList();
  List<String> get typeList => _typeMap.keys.toList();
  List<bool> get typeSelectedList => _typeMap.values.toList();
  List<String> get tierList => _tierMap.keys.toList();
  List<bool> get tierSelectedList => _tierMap.values.toList();

  void updateRegion(String key) {
    final value = _regionMap[key]!;
    _regionMap[key] = !value;
    _logger.fine('$key is ${_regionMap[key]}');
    _regionMap = Map.fromEntries(_regionMap.entries.toList());
    notifyListeners();
  }

  void updateType(String key) {
    final value = _typeMap[key]!;
    _typeMap[key] = !value;
    _logger.fine('$key is ${_typeMap[key]}');
    _typeMap = Map.fromEntries(_typeMap.entries.toList());
    notifyListeners();
  }

  void updateTier(String key) {
    final value = _tierMap[key]!;
    _tierMap[key] = !value;
    _logger.fine('$key is ${_tierMap[key]}');
    _tierMap = Map.fromEntries(_tierMap.entries.toList());
    notifyListeners();
  }
}
