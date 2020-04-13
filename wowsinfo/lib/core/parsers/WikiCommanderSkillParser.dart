import 'package:wowsinfo/core/data/GameServer.dart';
import 'package:wowsinfo/core/models/Wiki/WikiCommanderSkill.dart';

import 'APIParser.dart';

class WikiCommanderSkillParser extends APIParser {
  WikiCommanderSkillParser(GameServer server) : super(server) {
    this.link += '/wows/encyclopedia/crewskills/';
    addAPIKey();
    this.link += '&fields=name%2Cnation%2Ctype%2Ctier%2Cship_id%2Cship_id_str%2Cimages.small%2Cis_premium%2Cis_special%2Cdefault_profile.armour.health';
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
