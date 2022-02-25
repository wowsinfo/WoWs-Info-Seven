import 'package:flutter_test/flutter_test.dart';
import 'package:wowsinfo/models/game_server.dart';
import 'package:wowsinfo/services/api/wows/WikiCommanderSkillGetter.dart';
import 'package:wowsinfo/services/api/wows/WikiWarshipGetter.dart';

void main() {
  test('Parser, single page', () async {
    final parser = WikiCommanderSkillGetter(GameServer.fromIndex(0));
    var value = await parser.download();
    final skills = parser.parse(value);
    expect(skills.skill.length == 32, isTrue);
  });

  test('Parser, multiple pages', () async {
    final parser = WikiWarshipGetter(GameServer.fromIndex(3));
    var value = await parser.download();
    final s = parser.parse(value);
    expect(s.ships['3542005744'].name == 'AL Montpelier', isTrue);
  });
}
