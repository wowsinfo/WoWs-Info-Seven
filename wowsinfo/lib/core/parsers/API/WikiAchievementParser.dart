import 'package:wowsinfo/core/data/GameServer.dart';
import 'package:wowsinfo/core/models/Wiki/WikiAchievement.dart';

import 'APIParser.dart';

class WikiAchievementParser extends APIParser {
  WikiAchievementParser(GameServer server) : super(server) {
    this.link += '/wows/encyclopedia/achievements/';
    addAPIKey();
    this.link += '&fields=battle.hidden%2Cbattle.achievement_id%2Cbattle.name%2Cbattle.image%2Cbattle.image_inactive%2Cbattle.description';
  }

  @override
  WikiAchievement parse(List<Map<String, dynamic>> json) {
    if (json.length == 0) return null;
    final first = WikiAchievement.fromJson(json.removeAt(0)['data']['battle']);
    // Merge everything
    json.forEach((element) {
      first.achievement.addAll(WikiAchievement.fromJson(element['data']['battle']).achievement);
    });
    return first;
  }
}
