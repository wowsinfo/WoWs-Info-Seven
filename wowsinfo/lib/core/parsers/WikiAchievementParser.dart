import 'package:wowsinfo/core/data/GameServer.dart';
import 'package:wowsinfo/core/models/Wiki/WikiAchievement.dart';

import 'APIParser.dart';

class WikiAchievementParser extends APIParser {
  WikiAchievementParser(GameServer server) : super(server) {
    this.link += '/wows/encyclopedia/ships/';
    addAPIKey();
  }

  @override
  WikiAchievement parse(List<Map<String, dynamic>> json) {
    if (json.length == 0) return null;
    final first = WikiAchievement.fromJson(json.removeAt(0)['data']);
    // Merge everything
    json.forEach((element) {
      first.achievement.addAll(WikiAchievement.fromJson(element['data']).achievement);
    });
    return first;
  }
}
