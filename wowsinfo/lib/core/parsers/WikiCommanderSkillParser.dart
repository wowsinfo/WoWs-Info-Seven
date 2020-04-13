import 'package:wowsinfo/core/models/Wiki/WikiCommanderSkill.dart';

import 'APIParser.dart';

class WikiCommanderSkillParser extends APIParser {
  WikiCommanderSkillParser(String server) : super(server) {
    this.link += '/wows/encyclopedia/crewskills/';
    addAPIKey();
  }

  @override
  WikiCommanderSkill parse(Map<String, dynamic> json) {
    return WikiCommanderSkill.fromJson(json['data']);
  }
}
