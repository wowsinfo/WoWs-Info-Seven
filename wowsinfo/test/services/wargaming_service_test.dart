import 'package:flutter_test/flutter_test.dart';
import 'package:wowsinfo/models/wowsinfo/game_server.dart';
import 'package:wowsinfo/services/wargaming/wargaming_service.dart';

void main() {
  final testServer = GameServer(WoWsServer.asia);
  final testAccountId = '2011774448';

  test('test server status', () async {
    final service = WargamingService(testServer);
    final result = await service.getServerStatus();
    expect(result.hasError, false);
    expect(result.isNotEmpty, true);
    final data = result.data;
    if (data == null) fail('ServerStatus should be valid');
    expect(data.playersOnline, isNotNull);
    expect(data.playersOnline! > 0, isNotNull);
  });

  test('test search player henryquan', () async {
    final service = WargamingService(testServer);
    final result = await service.searchPlayer('henryquan');
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
    final service = WargamingService(testServer);
    final result = await service.searchClan('FFD');
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
    final service = WargamingService(testServer);
    final result = await service.getPlayerInformation(testAccountId);
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

    // TODO: add even more tests here
  });
}
