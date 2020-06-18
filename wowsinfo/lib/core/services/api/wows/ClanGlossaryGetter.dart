import 'package:wowsinfo/core/models/UI/GameServer.dart';
import 'package:wowsinfo/core/models/Clan/ClanGlossary.dart';

import 'APIParser.dart';

class ClanGlossaryGetter extends WoWsApiService {
  ClanGlossaryGetter(GameServer server) : super(server) {
    this.link += '/wows/clans/glossary/';
    addAPIKey();
    this.link += '&fields=clans_roles';
  }

  @override
  ClanGlossary parse(List<Map<String, dynamic>> json) {
    if (json.length == 0) return null;
    final first = ClanGlossary.fromJson(json[0]['data']);
    return first;
  }
}
