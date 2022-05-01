import 'package:flutter_test/flutter_test.dart';
import 'package:wowsinfo/models/wargaming/player_recent_overview.dart';
import 'package:wowsinfo/models/wowsinfo/game_server.dart';
import 'package:wowsinfo/services/wargaming/wargaming_service.dart';

import '../dummies/dummy_service.dart';

void main() {
  // Test a public account
  final testServer = GameServer(WoWsServer.asia);
  final testService = WargamingService(testServer);
  const testAccountId = '2011774448';

  // Test a hidden account
  final hiddenServer = GameServer(WoWsServer.northAmerica);
  final hiddenService = WargamingService(hiddenServer);
  const hiddenAccountId = '1025459900';

  // the local data service
  final localService = DummyService();

  test('test server status', () async {
    final result = await testService.getServerStatus();
    expect(result.hasError, false);
    expect(result.isNotEmpty, true);
    final data = result.data;
    if (data == null) fail('ServerStatus should be valid');
    expect(data.playersOnline, isNotNull);
    expect(data.playersOnline! > 0, isNotNull);
  });

  test('test search player henryquan', () async {
    final result = await testService.searchPlayer('henryquan');
    expect(result.hasError, false);
    expect(result.isNotEmpty, true);
    final data = result.data;
    if (data == null) fail('PlayerResultList should be valid');
    // there should be only one result which is me
    expect(data.isNotEmpty, true);
    expect(data[0].nickname, 'HenryQuan');
    expect(data[0].createdAt, isNotNull);
    expect(data[0].createdAt?.dateString, '2016.03.01');
  });

  test('test search clan tag FFD', () async {
    final result = await testService.searchClan('FFD');
    expect(result.hasError, false);
    expect(result.isNotEmpty, true);
    final data = result.data;
    if (data == null) fail('ClanResultList should be valid');
    // there should be only one result which is me
    expect(data.isNotEmpty, true);
    expect(data[0].tag, 'FFD');
    expect(data[0].name, 'Fubuki Fubuki Dance');
    expect(data[0].createdAt, isNotNull);
    expect(data[0].createdAt?.dateString, '2018.06.02');
  });

  test('test player information by ID', () async {
    final result = await testService.getPlayerInformation(testAccountId);
    expect(result.hasError, false);
    expect(result.isNotEmpty, true);
    final data = result.data;
    if (data == null) fail('PlayerInformation should be valid');
    expect(data.nickname, 'HenryQuan');
    expect(data.createdAt, isNotNull);
    expect(data.createdAt?.dateString, '2016.03.03');
    expect(data.updatedAt, isNotNull);
    expect(data.statistics?.pve, isNotNull);
    expect(data.statistics?.pve?.battles, isNotNull);
    expect(data.statistics?.pvpDiv2, isNotNull);
    expect(data.statistics?.pvpDiv3, isNotNull);
    expect(data.statistics?.rankSolo, isNotNull);

    // make sure all weapons are valid
    final pvp = data.statistics?.pvp;
    expect(pvp, isNotNull);
    expect(pvp!.aircraft, isNotNull);
    expect(pvp.torpedoes, isNotNull);
    expect(pvp.mainBattery, isNotNull);
    expect(pvp.secondaries, isNotNull);
    expect(pvp.ramming, isNotNull);

    // test hidden account
    final hiddenResult = await hiddenService.getPlayerInformation(
      hiddenAccountId,
    );
    expect(hiddenResult.hasError, false);
    expect(hiddenResult.isNotEmpty, true);
    final hiddenData = hiddenResult.data;
    // The data is still valid but we don't know much about the player's statistics
    if (hiddenData == null) fail('PlayerInformation should be valid');
    expect(hiddenData.hiddenProfile, true);
    expect(hiddenData.statistics, isNull);
  });

  test('test player achievements by ID', () async {
    final result = await testService.getPlayerAchievements(testAccountId);
    expect(result.hasError, false);
    expect(result.isNotEmpty, true);
    final data = result.data;
    if (data == null) fail('PlayerAchievement should be valid');
    expect(data.battle, isNotNull);
    expect(data.progress, isNotNull);
    expect(data.battle?.isNotEmpty, true);
    expect(data.progress?.isNotEmpty, true);

    // test hidden account
    final hiddenResult = await hiddenService.getPlayerAchievements(
      hiddenAccountId,
    );
    expect(hiddenResult.hasError, false);
    expect(hiddenResult.isNotEmpty, true);
    final hiddenData = hiddenResult.data;
    if (hiddenData == null) fail('PlayerAchievement should be valid');
    // no data should be returned
    expect(hiddenData.battle, isNull);
    expect(hiddenData.progress, isNull);
  });

  test('test player recent overview data', () async {
    final goodData = await localService.loadGoodRecentOverview();
    final goodOverview = PlayerRecentOverview.fromJson(goodData);
    final pvp = goodOverview.pvp;
    expect(pvp, isNotNull);
    expect(pvp!.length, 2);

    final emptyData = await localService.loadEmptyRecentOverview();
    final emptyOverview = PlayerRecentOverview.fromJson(emptyData);
    expect(emptyOverview.pvp, isNull);

    final hiddenData = await localService.loadHiddenRecentOverview();
    final hiddenOverview = PlayerRecentOverview.fromJson(hiddenData);
    expect(hiddenOverview.pvp, isNull);
  });
}
