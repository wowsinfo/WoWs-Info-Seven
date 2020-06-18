import 'package:wowsinfo/core/models/UI/GameServer.dart';
import 'package:wowsinfo/core/models/Wiki/WikiCommanderSkill.dart';

import 'APIParser.dart';

class WikiCommanderSkillGetter extends WoWsApiService {
  WikiCommanderSkillGetter(GameServer server) : super(server) {
    this.link += '/wows/encyclopedia/crewskills/';
    addAPIKey();
  }

  @override
  WikiCommanderSkill parse(List<Map<String, dynamic>> json) {
    if (json.length == 0) return null;
    final first = WikiCommanderSkill.fromJson(json.removeAt(0)['data']);
    // Merge everything
    json.forEach((element) {
      first.skill.addAll(WikiCommanderSkill.fromJson(element['data']).skill);
    });
    return first;
  }
}
