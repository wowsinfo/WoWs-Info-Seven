import 'package:flutter_test/flutter_test.dart';
import 'package:wowsinfo/core/data/AppSettings.dart';
import 'package:wowsinfo/core/data/CachedData.dart';
import 'package:wowsinfo/core/models/UI/GameServer.dart';
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
    expect(a.domain == 'asia', isTrue);
    expect(a.numberWebsite == 'https://asia.wows-numbers.com', isTrue);

    a.updateServer(Server.EU);
    expect(a.server == Server.EU, isTrue);
    expect(a.numberWebsite == 'https://wows-numbers.com', isTrue);

    a.updateServer(Server.RU);
    expect(a.server == Server.RU, isTrue);

    final b = GameServer.fromIndex(3);
    expect(b.domain == 'asia', isTrue);
    expect(b.numberWebsite == 'https://asia.wows-numbers.com', isTrue);
  });
}
