import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:wowsinfo/core/models/WoWs/BasicPlayerInfo.dart';
import 'package:wowsinfo/core/models/WoWs/ClanInfo.dart';
import 'package:wowsinfo/core/models/WoWs/PlayerAchievement.dart';
import 'package:wowsinfo/core/models/WoWs/PlayerShipInfo.dart';
import 'package:wowsinfo/core/models/WoWs/RankPlayerInfo.dart';
import 'package:wowsinfo/core/models/WoWs/RankPlayerShipInfo.dart';
import 'package:wowsinfo/core/models/WoWs/SearchPlayerResult.dart';
import 'package:wowsinfo/core/models/WoWs/WikiShipInfo.dart';

void main() {
  test('Load basic_player_info into memory', () async {
    final file = File('test/json/basic_player_info.json');
    final jsonString = await file.readAsString();
    Map<String, dynamic> jsonMap = jsonDecode(jsonString);
    
    final info = BasicPlayerInfo(jsonMap['data']);

    expect(info != null, isTrue);
    expect(info.statistic != null, isTrue);
    expect(info.statistic.pvp.mainBattery.hit == 178284, isTrue);
  });

  test('Load basic_player_info_hidden into memory', () async {
    final file = File('test/json/basic_player_info_hidden.json');
    final jsonString = await file.readAsString();
    Map<String, dynamic> jsonMap = jsonDecode(jsonString);
    
    final info = BasicPlayerInfo(jsonMap['data']);

    expect(info != null, isTrue);
    expect(info.statistic == null, isTrue);
  });

  test('Load clan_info into memory', () async {
    final file = File('test/json/clan_info.json');
    final jsonString = await file.readAsString();
    Map<String, dynamic> jsonMap = jsonDecode(jsonString);
    
    final info = ClanInfo(jsonMap['data']);

    expect(info != null, isTrue);
    expect(info.member['2011774448'].accountName == 'HenryQuan', isTrue);
  });

  test('Load player_achievement into memory', () async {
    final file = File('test/json/player_achievement.json');
    final jsonString = await file.readAsString();
    Map<String, dynamic> jsonMap = jsonDecode(jsonString);
    
    final player = PlayerAchievement(jsonMap['data']);

    expect(player != null, isTrue);
    expect(player.achievement['FOOLSDAY_TROOPER'] == 4, isTrue);
  });

  test('Load player_rank_info into memory', () async {
    final file = File('test/json/player_rank_info.json');
    final jsonString = await file.readAsString();
    Map<String, dynamic> jsonMap = jsonDecode(jsonString);
    
    final info = RankPlayerInfo(jsonMap['data']);

    expect(info != null, isTrue);
    expect(info.season['101'].rankInfo.maxRank == 0, isFalse);
    expect(info.season['110'].rankInfo.maxRank == 0, isTrue);
  });

  test('Load player_ship into memory', () async {
    final file = File('test/json/player_ship.json');
    final jsonString = await file.readAsString();
    Map<String, dynamic> jsonMap = jsonDecode(jsonString);
    
    final ship = PlayerShipInfo(jsonMap['data']);

    expect(ship != null, isTrue);
    expect(ship.isSingleShip, isTrue);
    expect(ship.ships[0].pvp.battle == 128, isTrue);
  });

  test('Load rank_player_ship_info into memory', () async {
    final file = File('test/json/rank_player_ship_info.json');
    final jsonString = await file.readAsString();
    Map<String, dynamic> jsonMap = jsonDecode(jsonString);
    
    final ship = RankPlayerShipInfo(jsonMap['data']);

    expect(ship != null, isTrue);
    expect(ship.ships.length > 0, isTrue);
    expect(ship.ships[0].season['101'].rankSolo.secondBattery.hit == 0, isTrue);
  });

  /// This will fail because of `Hive`
  test('Load search_player into memory', () async {
    final file = File('test/json/search_player.json');
    final jsonString = await file.readAsString();
    Map<String, dynamic> jsonMap = jsonDecode(jsonString);
    
    final player = SearchPlayerResult(jsonMap['data']);

    expect(player != null, isTrue);
    expect(player.players.length > 0, isTrue);
    expect(player.players[0].nickname == 'henry000', isTrue);
  });

  test('Load ship_wiki into memory', () async {
    print('Test destroyer');
    final ddfile = File('test/json/ship_wiki_fubuki.json');
    final ddjsonString = await ddfile.readAsString();
    Map<String, dynamic> ddMap = jsonDecode(ddjsonString);
    
    final dd = WikiShipInfo(ddMap['data']);

    expect(dd != null, isTrue);
    expect(dd.modulesTree.parts['3760598736'].moduleIdStr == 'PJUT509', isTrue);
    expect(dd.defaultProfile.artillery.shell['HE'].damage == 2150, isTrue);

    print('Test aircraft carrior');
    final cvfile = File('test/json/ship_wiki_shokaku.json');
    final cvjsonString = await cvfile.readAsString();
    Map<String, dynamic> cvMap = jsonDecode(cvjsonString);
    
    final cv = WikiShipInfo(cvMap['data']);

    expect(cv != null, isTrue);
    expect(cv.defaultProfile.diveBomber.accuracy.max == 120.0, isTrue);
    expect(cv.defaultProfile.torpedo == null, isTrue);

    print('Test battleships');
    final bbfile = File('test/json/ship_wiki_gneisenau.json');
    final bbjsonString = await bbfile.readAsString();
    Map<String, dynamic> bbMap = jsonDecode(bbjsonString);
    
    final bb = WikiShipInfo(bbMap['data']);

    expect(bb != null, isTrue);
    expect(bb.upgrade.length == 12, isTrue);
    expect(bb.defaultProfile.torpedo.reloadTime == 68, isTrue);
    expect(bb.defaultProfile.diveBomber == null, isTrue);
  });
}
