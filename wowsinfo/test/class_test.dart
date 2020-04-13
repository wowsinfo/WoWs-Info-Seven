import 'package:flutter_test/flutter_test.dart';
import 'package:wowsinfo/core/data/AppSettings.dart';
import 'package:wowsinfo/core/data/CachedData.dart';
import 'package:wowsinfo/core/data/GameServer.dart';
import 'package:wowsinfo/core/data/Preference.dart';

void main() {
  test('Test Preference.shared, AppSettings.shared and CachedData.shared', () {
    final a = Preference.shared;
    final b = Preference.shared;
    expect(identical(a, b), isTrue);

    final c = AppSettings.shared;
    final d = AppSettings.shared;
    expect(identical(c, d), isTrue);

    final e = CachedData.shared;
    final f = CachedData.shared;
    expect(identical(e, f), isTrue);
  });

  test('Test GameServer', () {
    final a = GameServer(Server.ASIA);
    expect(a.toDomain() == 'asia', isTrue);
    expect(a.toWoWsNumbers() == 'https://asia.wows-numbers.com', isTrue);

    a.updateServer(Server.EU);
    expect(a.server == Server.EU, isTrue);
    expect(a.toWoWsNumbers() == 'https://wows-numbers.com', isTrue);

    a.updateServer(Server.RU);
    expect(a.server == Server.RU, isTrue);
  });
}
