import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;
import 'package:logging/logging.dart';
import 'package:wowsinfo/foundation/helpers/time_tracker.dart';
import 'package:wowsinfo/models/gamedata/ability.dart';
import 'package:wowsinfo/models/gamedata/achievement.dart';
import 'package:wowsinfo/models/gamedata/aircraft.dart';
import 'package:wowsinfo/models/gamedata/alias.dart';

/// This repository manages game data from WoWs-Game-Data
class GameRepository {
  /// The shared instance of the AppRepository.
  static final GameRepository instance = GameRepository._init();
  GameRepository._init();

  bool _initialised = false;
  final _logger = Logger('GameRepository');

  late final Map<String, Alias> _alias;
  late final Map<String, Ability> _abilities;
  late final Map<String, Achievement> _achievements;
  late final Map<String, Aircraft> _aircrafts;

  /// Load wowsinfo.json from /gamedata/app/data/
  Future<void> initialise() async {
    if (_initialised) {
      _logger.severe('GameRepository already initialised');
      throw Exception('GameRepository is already initialised');
    }

    final _timer = TimeTracker();
    final jsonString = await rootBundle.loadString(
      'gamedata/app/data/wowsinfo.json',
      cache: false,
    );
    _timer.log(message: 'Loaded wowsinfo.json');
    final dataObject = jsonDecode(jsonString);
    _timer.log(message: 'Parsed wowsinfo.json');

    // decode data into models and store them in the repository
    _alias = (dataObject['alias'] as Map).map((key, value) {
      return MapEntry(key, Alias.fromJson(value));
    });
    _abilities = (dataObject['abilities'] as Map).map((key, value) {
      return MapEntry(key, Ability.fromJson(value));
    });
    _achievements = (dataObject['achievements'] as Map).map((key, value) {
      return MapEntry(key, Achievement.fromJson(value));
    });
    _aircrafts = (dataObject['aircrafts'] as Map).map((key, value) {
      return MapEntry(key, Aircraft.fromJson(value));
    });

    _initialised = true;
    _timer.log(message: 'Initialised GameRepository');
  }

  /// Get an alias string by its key.
  /// If the alias is not found, it will return null
  String? aliasOf(String key) {
    return _alias[key]?.alias;
  }

  /// Get an ability by its key.
  /// If the ability is not found, it will return null
  Ability? abilityOf(String key) {
    return _abilities[key];
  }

  /// Get an achievement by its key.
  /// If the achievement is not found, it will return null
  Achievement? achievementOf(String key) {
    return _achievements[key];
  }

  /// Get an aircraft by its key.
  /// If the aircraft is not found, it will return null
  Aircraft? aircraftOf(String key) {
    return _aircrafts[key];
  }
}
