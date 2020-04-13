import 'package:flutter_test/flutter_test.dart';
import 'package:wowsinfo/core/data/GameServer.dart';
import 'package:wowsinfo/core/parsers/API/WikiCommanderSkillParser.dart';
import 'package:wowsinfo/core/parsers/API/WikiWarshipParser.dart';

void main() {
  test('Parser, single page', () async {
    final parser = WikiCommanderSkillParser(GameServer.fromIndex(0));
    var value = await parser.download();
    final skills = parser.parse(value);
    expect(skills.skill.length == 32, isTrue);
  });

  test('Parser, multiple pages', () async {
    final parser = WikiWarshipParser(GameServer.fromIndex(3));
    var value = await parser.download();
    final s = parser.parse(value);
    expect(s.ships['3542005744'].name == 'AL Montpelier', isTrue);
  });
}