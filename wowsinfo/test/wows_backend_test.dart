import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:wowsinfo/core/models/WoWs/BasicPlayerInfo.dart';
import 'package:wowsinfo/core/models/WoWs/ClanInfo.dart';

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
}
