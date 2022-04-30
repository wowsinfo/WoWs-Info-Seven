import 'package:flutter_test/flutter_test.dart';
import 'package:wowsinfo/models/wowsinfo/game_server.dart';

void main() {
  test('test game server', () {
    expect(GameServer.defaultServer, WoWsServer.asia);

    // asia
    final server1 = GameServer(WoWsServer.asia);
    expect(server1.domain, 'asia');
    expect(server1.prefix, 'asia');
    expect(server1.numberDomain, 'asia.');

    // russia
    final server2 = GameServer(WoWsServer.russia);
    expect(server2.domain, 'ru');
    expect(server2.prefix, 'ru');
    expect(server2.numberDomain, 'ru.');

    // europe
    final server3 = GameServer(WoWsServer.europe);
    expect(server3.domain, 'eu');
    expect(server3.prefix, 'eu');
    expect(server3.numberDomain, '');

    // north america
    final server4 = GameServer(WoWsServer.northAmerica);
    expect(server4.domain, 'com');
    expect(server4.prefix, 'na');
    expect(server4.numberDomain, 'na.');

    // asia from index
    final serverFromIndex = GameServer.fromIndex(3);
    expect(serverFromIndex.domain, server1.domain);

    // should fail
    expect(() => GameServer.fromIndex(5), throwsArgumentError);
    expect(() => GameServer.fromIndex(4), throwsArgumentError);
    expect(() => GameServer.fromIndex(-1), throwsArgumentError);
    expect(() => GameServer.fromIndex(-2), throwsArgumentError);
  });
}
