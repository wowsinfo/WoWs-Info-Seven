import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;
import 'package:logging/logging.dart';
import 'package:wowsinfo/foundation/helpers/time_tracker.dart';
import 'package:wowsinfo/models/gamedata/ability.dart';
import 'package:wowsinfo/models/gamedata/achievement.dart';
import 'package:wowsinfo/models/gamedata/aircraft.dart';
import 'package:wowsinfo/models/gamedata/alias.dart';
import 'package:wowsinfo/models/gamedata/commander_skills.dart';
import 'package:wowsinfo/models/gamedata/exterior.dart';
import 'package:wowsinfo/models/gamedata/game_info.dart';
import 'package:wowsinfo/models/gamedata/modernization.dart';
import 'package:wowsinfo/models/gamedata/projectile.dart';
import 'package:wowsinfo/models/gamedata/ship.dart';
import 'package:wowsinfo/localisation/localisation.dart';
import 'package:wowsinfo/models/gamedata/ship_additional.dart';
import 'package:wowsinfo/models/gamedata/skills.dart';

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
  late final Map<String, CommanderSkill> _skills;
  late final Map<String, ShipAdditional> _shipAdditionals;
  late final GameInfo _gameInfo;
  late final CommandSkillInfo _commandSkills;

  late final List<Achievement> achievementList;
  late final List<Ability> consumableList;
  late final List<Exterior> exteriorList;
  late final List<Modernization> modernizationList;
  late final List<Ship> shipList;
  late final List<String> shipRegionList;
  late final List<String> shipTypeList;
  late final List<Flag> usefulFlagList;

  /// Load wowsinfo.json from /data/live/app/data/
  Future<void> initialise() async {
    if (_initialised) {
      _logger.severe('GameRepository already initialised');
      throw Exception('GameRepository is already initialised');
    }

    final timer = TimeTracker();

    // load game data
    final jsonString = await rootBundle.loadString(
      'data/live/app/data/wowsinfo.json',
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
    _skills = (dataObject['skills'] as Map).map((key, value) {
      return MapEntry(key, CommanderSkill.fromJson(value));
    });
    _shipAdditionals = (dataObject['number'] as Map).map((key, value) {
      return MapEntry(key, ShipAdditional.fromJson(value));
    });
    _gameInfo = GameInfo.fromJson(dataObject['game']);
    timer.log(message: 'Decoded wowsinfo.json');

    // load commander skills
    final commanderSkills = await rootBundle.loadString(
      'assets/skills.json',
      cache: false,
    );
    timer.log(message: 'Loaded skills.json');
    _commandSkills = CommandSkillInfo.fromJson(jsonDecode(commanderSkills));
    timer.log(message: 'Decoded skills.json');

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

    // get all flags which have a modifier
    usefulFlagList = exteriorList
        .where((e) => e.isFlag && (e.modifiers?.isNotEmpty ?? false))
        .toList()
      ..sort((a, b) => b.id.compareTo(a.id));
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
    return Localisation.instance.stringOf(ship.name);
  }

  ShipAdditional? shipAdditionalOf(String id) {
    return _shipAdditionals[id];
  }

  Map<String, List<List<ShipSkill>>> get commanderSkills =>
      _commandSkills.shipTypes;

  List<List<ShipSkill>> commandSkillsOf(CommanderSkillType type) {
    final skills = _commandSkills.shipTypes[type.rawName];
    if (skills == null) throw Exception('No skills for $type');
    return skills;
  }

  CommanderSkill? skillOf(String name) {
    return _skills[name];
  }
}
