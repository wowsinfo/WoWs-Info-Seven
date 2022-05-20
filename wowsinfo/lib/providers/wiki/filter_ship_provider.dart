import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart';
import 'package:wowsinfo/models/gamedata/game_info.dart';
import 'package:wowsinfo/repositories/game_repository.dart';

/// Provides data and handle logic for `showFilterShipDialog`
class FilterShipProvider with ChangeNotifier {
  final _regions = GameRepository.instance.shipRegionList;
  final _types = GameRepository.instance.shipTypeList;
  final _logger = Logger('FilterShipProvider');

  late final List<String> _regionList =
      _regions.map((region) => _getStringOf(region)).toList();
  late final List<String> _typeList =
      _types.map((type) => _getStringOf(type)).toList();
  final List<String> _tierList = GameInfo.tiers;

  String _getStringOf(String key) {
    final langKey = 'IDS_' + key.toUpperCase();
    final name = GameRepository.instance.stringOf(langKey);

    if (name == null) {
      _logger.severe('$langKey is invalid!');
      throw Exception('Failed to get filter name: $langKey');
    }

    return name;
  }
}
