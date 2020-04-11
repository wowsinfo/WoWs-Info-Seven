import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:wowsinfo/core/models/Wiki/WikiAchievement.dart';
import 'package:wowsinfo/core/models/Wiki/WikiCollection.dart';
import 'package:wowsinfo/core/models/Wiki/WikiCollectionItem.dart';
import 'package:wowsinfo/core/models/Wiki/WikiCommanderSkill.dart';
import 'package:wowsinfo/core/models/Wiki/WikiConsumable.dart';
import 'package:wowsinfo/core/models/Wiki/WikiEncyclopedia.dart';
import 'package:wowsinfo/core/models/Wiki/WikiGameMap.dart';
import 'package:wowsinfo/core/models/Wiki/WikiWarship.dart';

void main() {
  test('Load achievement into memory', () async {
    final file = File('test/json/achievement.json');
    final jsonString = await file.readAsString();
    Map<String, dynamic> jsonMap = jsonDecode(jsonString);
    final output = jsonEncode(jsonMap['data']['battle']);
    
    final a = WikiAchievement.fromJson(jsonMap['data']['battle']);
    expect(a.achievement['TOP_LEAGUE_CLAN_SEASON_6'].achievementId == 'TOP_LEAGUE_CLAN_SEASON_6', isTrue);
    final myOutput = jsonEncode(a.toJson());

    expect(myOutput == output, isTrue);
  });

  test('Load collection_item into memory', () async {
    final file = File('test/json/collection_item.json');
    final jsonString = await file.readAsString();
    Map<String, dynamic> jsonMap = jsonDecode(jsonString);
    final output = jsonEncode(jsonMap['data']);
    
    final item = WikiCollectionItem.fromJson(jsonMap['data']);
    final myOutput = jsonEncode(item.toJson());

    expect(myOutput == output, isTrue);
  });

  test('Load collection into memory', () async {
    final file = File('test/json/collection.json');
    final jsonString = await file.readAsString();
    Map<String, dynamic> jsonMap = jsonDecode(jsonString);
    final output = jsonEncode(jsonMap['data']);
    
    final collection = WikiCollection.fromJson(jsonMap['data']);
    final myOutput = jsonEncode(collection.toJson());

    expect(myOutput == output, isTrue);
  });

  test('Load commander_skill into memory', () async {
    final file = File('test/json/commander_skill.json');
    final jsonString = await file.readAsString();
    Map<String, dynamic> jsonMap = jsonDecode(jsonString);
    final output = jsonEncode(jsonMap['data']);
    
    final skill = WikiCommanderSkill.fromJson(jsonMap['data']);
    final myOutput = jsonEncode(skill.toJson());

    expect(myOutput == output, isTrue);
  });

  test('Load consumable into memory', () async {
    final file = File('test/json/consumable.json');
    final jsonString = await file.readAsString();
    Map<String, dynamic> jsonMap = jsonDecode(jsonString);
    final output = jsonEncode(jsonMap['data']);
    
    final consumable = WikiConsumable.fromJson(jsonMap['data']);
    final myOutput = jsonEncode(consumable.toJson());

    expect(myOutput == output, isTrue);
  });

  test('Load encyclopedia into memory', () async {
    final file = File('test/json/encyclopedia.json');
    final jsonString = await file.readAsString();
    Map<String, dynamic> jsonMap = jsonDecode(jsonString);
    final output = jsonEncode(jsonMap['data']);
    
    final encyclopedia = WikiEncyclopedia.fromJson(jsonMap['data']);
    final myOutput = jsonEncode(encyclopedia.toJson());

    expect(myOutput == output, isTrue);
  });

  test('Load game_map into memory', () async {
    final file = File('test/json/game_map.json');
    final jsonString = await file.readAsString();
    Map<String, dynamic> jsonMap = jsonDecode(jsonString);
    final output = jsonEncode(jsonMap['data']);
    
    final gameMap = WikiGameMap.fromJson(jsonMap['data']);
    final myOutput = jsonEncode(gameMap.toJson());

    expect(myOutput == output, isTrue);
  });

  test('Load warship into memory', () async {
    final file = File('test/json/warship.json');
    final jsonString = await file.readAsString();
    Map<String, dynamic> jsonMap = jsonDecode(jsonString);
    final output = jsonEncode(jsonMap['data']);
    
    final warship = WikiWarship.fromJson(jsonMap['data']);
    final myOutput = jsonEncode(warship.toJson());

    expect(myOutput == output, isTrue);
  });
}
