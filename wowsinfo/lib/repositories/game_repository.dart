import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;
import 'package:logging/logging.dart';
import 'package:wowsinfo/extensions/number.dart';
import 'package:wowsinfo/foundation/helpers/time_tracker.dart';
import 'package:wowsinfo/models/gamedata/ability.dart';
import 'package:wowsinfo/models/gamedata/achievement.dart';
import 'package:wowsinfo/models/gamedata/aircraft.dart';
import 'package:wowsinfo/models/gamedata/alias.dart';
import 'package:wowsinfo/models/gamedata/exterior.dart';
import 'package:wowsinfo/models/gamedata/game_info.dart';
import 'package:wowsinfo/models/gamedata/modernization.dart';
import 'package:wowsinfo/models/gamedata/projectile.dart';
import 'package:wowsinfo/models/gamedata/ship.dart';

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
  late final Map<String, Exterior> _exteriors;
  late final Map<String, Modernization> _modernizations;
  late final Map<String, Projectile> _projectiles;
  late final Map<String, Ship> _ships;
  late final GameInfo _gameInfo;

  late final Map<String, Map<String, String>> _lang;
  late String _gameLang;

  late final List<Achievement> achievementList;
  late final List<Ability> consumableList;
  late final List<Exterior> exteriorList;
  late final List<Modernization> modernizationList;
  late final List<Ship> shipList;
  late final List<String> shipRegionList;
  late final List<String> shipTypeList;

  /// Load wowsinfo.json from /gamedata/app/data/
  Future<void> initialise() async {
    if (_initialised) {
      _logger.severe('GameRepository already initialised');
      throw Exception('GameRepository is already initialised');
    }

    final timer = TimeTracker();

    // load game data
    final jsonString = await rootBundle.loadString(
      'gamedata/app/data/wowsinfo.json',
      cache: false,
    );
    timer.log(message: 'Loaded wowsinfo.json');

    final dataObject = jsonDecode(jsonString);
    timer.log(message: 'Parsed wowsinfo.json');

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
    _exteriors = (dataObject['exteriors'] as Map).map((key, value) {
      return MapEntry(key, Exterior.fromJson(value));
    });
    _modernizations = (dataObject['modernizations'] as Map).map((key, value) {
      return MapEntry(key, Modernization.fromJson(value));
    });
    _projectiles = (dataObject['projectiles'] as Map).map((key, value) {
      return MapEntry(key, Projectile.fromJson(value));
    });
    _ships = (dataObject['ships'] as Map).map((key, value) {
      return MapEntry(key, Ship.fromJson(value));
    });
    _gameInfo = GameInfo.fromJson(dataObject['game']);
    timer.log(message: 'Decoded wowsinfo.json');

    // load the language file
    final langString = await rootBundle.loadString(
      'gamedata/app/lang/lang.json',
      cache: false,
    );
    timer.log(message: 'Loaded lang.json');

    final langObject = jsonDecode(langString);
    timer.log(message: 'Parsed lang.json');

    _lang = (langObject as Map).map((key, value) {
      return MapEntry(key, (value as Map).cast<String, String>());
    });
    _gameLang = 'en';
    timer.log(message: 'Decoded lang.json');

    _generateLists();
    _initialised = true;
    timer.log(message: 'Initialised GameRepository');
  }

  void _generateLists() {
    // sort achievements by id
    achievementList = _achievements.values.toList();
    achievementList.sort((a, b) => b.id.compareTo(a.id));

    // sort consumables by id
    consumableList = _abilities.values.toList();
    consumableList.sort((a, b) => b.id.compareTo(a.id));

    // sort exteriors by id
    exteriorList = _exteriors.values.toList();
    exteriorList.sort((a, b) => b.id.compareTo(a.id));

    // sort modernizations by id
    modernizationList = _modernizations.values.toList();
    modernizationList.sort((a, b) => b.greater(a));

    // sort ships by id
    shipList = _ships.values.toList();
    shipList.sort((a, b) => b.greater(a));

    // sort only to make sure they are the same
    shipRegionList = _gameInfo.regions;
    shipRegionList.sort();
    shipTypeList = _gameInfo.types;
    shipTypeList.sort();
  }

  void setLanguage(String language) {
    _gameLang = language;
  }

  String? stringOf(
    String? key, {
    Map<String, dynamic>? constants,
    String? prefix,
  }) {
    if (key == null) {
      _logger.severe('Key is null');
      return null;
    }

    if (_lang[_gameLang] == null) {
      _logger.severe('Language $_gameLang not found');
      return null;
    }

    var langKey = key.toUpperCase();
    if (prefix != null) {
      langKey = prefix + langKey;
    }
    final rawString = _lang[_gameLang]![langKey];
    if (rawString == null) {
      _logger.severe('Language key $langKey not found');
      return null;
    }

    // TODO: we can move this to probably another class if needed
    if (constants == null || constants.isEmpty) {
      return rawString;
    }

    // put constants into the string if needed
    // check if value has %(key) in it
    var formattedString = rawString;
    final regex = RegExp(r'%\((.*?)\)s');
    final matches = regex.allMatches(rawString);
    for (final match in matches) {
      final key = match.group(1);
      if (key == null) {
        _logger.severe('Invalid match, key is null');
        continue;
      }

      // the key doesn't include _percent at the end
      final constantKey = key.replaceAll('_percent', '');
      var constantValue = constants[constantKey];
      _logger.fine('Constant $key = $constantValue');
      if (key.endsWith('_percent')) {
        final number = constantValue as num;
        // format to percentage
        constantValue = '${(number * 100).toDecimalString()}%';
      }

      formattedString = formattedString.replaceAll(
        '%($key)s',
        constantValue.toString(),
      );
    }

    return formattedString;
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

  /// Get a flag by its key.
  /// If the flag is not found, it will return null
  Flag? flagOf(String key) {
    final flag = _exteriors[key];
    if (flag == null) return null;
    // make sure this is a flag not a camouflage
    if (flag.type != 'Flags') {
      throw Exception('$key is not a flag');
    }

    return flag;
  }

  /// Get a camouflage (permouflage or skin) by its key.
  /// If the camouflage is not found, it will return null
  Camouflage? camouflageOf(String key) {
    final camouflage = _exteriors[key];
    if (camouflage == null) return null;
    // make sure this is a camouflage not a flag
    if (camouflage.type == 'Flags') {
      throw Exception('$key is not a camouflage');
    }

    return camouflage;
  }

  /// Get a modernization by its key.
  /// If the modernization is not found, it will return null
  Modernization? modernizationOf(String key) {
    return _modernizations[key];
  }

  /// Get a projectile by its key.
  /// If the projectile is not found, it will return null
  Projectile? projectileOf(String key) {
    return _projectiles[key];
  }

  /// Get a ship by its id.
  /// If the ship is not found, it will return null
  Ship? shipOf(String id) {
    // TODO: we can check if this id is numeric
    return _ships[id];
  }

  String? shipNameOf(String id) {
    final ship = shipOf(id);
    if (ship == null) return null;
    return stringOf(ship.name);
  }
}
