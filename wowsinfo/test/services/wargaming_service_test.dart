import 'package:flutter_test/flutter_test.dart';
import 'package:wowsinfo/models/wowsinfo/game_server.dart';
import 'package:wowsinfo/services/wargaming/wargaming_service.dart';

void main() {
  final testServer = GameServer(WoWsServer.asia);
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
  });
}
