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
    
    final encyclopedia = WikiAchievement.fromJson(jsonMap['data']['battle']);
    final myOutput = jsonEncode(encyclopedia.toJson());

    expect(myOutput == output, isTrue);
  });

  test('Load collection_item into memory', () async {
    final file = File('test/json/collection_item.json');
    final jsonString = await file.readAsString();
    Map<String, dynamic> jsonMap = jsonDecode(jsonString);
    final output = jsonEncode(jsonMap['data']);
    
    final encyclopedia = WikiCollectionItem.fromJson(jsonMap['data']);
    final myOutput = jsonEncode(encyclopedia.toJson());

    expect(myOutput == output, isTrue);
  });

  test('Load collection into memory', () async {
    final file = File('test/json/collection.json');
    final jsonString = await file.readAsString();
    Map<String, dynamic> jsonMap = jsonDecode(jsonString);
    final output = jsonEncode(jsonMap['data']);
    
    final encyclopedia = WikiCollection.fromJson(jsonMap['data']);
    final myOutput = jsonEncode(encyclopedia.toJson());

    expect(myOutput == output, isTrue);
  });

  test('Load commander_skill into memory', () async {
    final file = File('test/json/commander_skill.json');
    final jsonString = await file.readAsString();
    Map<String, dynamic> jsonMap = jsonDecode(jsonString);
    final output = jsonEncode(jsonMap['data']);
    
    final encyclopedia = WikiCommanderSkill.fromJson(jsonMap['data']);
    final myOutput = jsonEncode(encyclopedia.toJson());

    expect(myOutput == output, isTrue);
  });

  test('Load consumable into memory', () async {
    final file = File('test/json/consumable.json');
    final jsonString = await file.readAsString();
    Map<String, dynamic> jsonMap = jsonDecode(jsonString);
    final output = jsonEncode(jsonMap['data']);
    
    final encyclopedia = WikiConsumable.fromJson(jsonMap['data']);
    final myOutput = jsonEncode(encyclopedia.toJson());

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
    
    final encyclopedia = WikiGameMap.fromJson(jsonMap['data']);
    final myOutput = jsonEncode(encyclopedia.toJson());

    expect(myOutput == output, isTrue);
  });

  test('Load warship into memory', () async {
    final file = File('test/json/warship.json');
    final jsonString = await file.readAsString();
    Map<String, dynamic> jsonMap = jsonDecode(jsonString);
    final output = jsonEncode(jsonMap['data']);
    
    final encyclopedia = WikiWarship.fromJson(jsonMap['data']);
    final myOutput = jsonEncode(encyclopedia.toJson());

    expect(myOutput == output, isTrue);
  });

}
