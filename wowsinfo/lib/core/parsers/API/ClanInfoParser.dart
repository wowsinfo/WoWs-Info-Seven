import 'package:wowsinfo/core/data/GameServer.dart';
import 'package:wowsinfo/core/models/WoWs/ClanInfo.dart';
import 'APIParser.dart';

class ClanInfoParser extends APIParser {
  ClanInfoParser(GameServer server, String clanId) : super(server) {
    this.link += '/wows/clans/info/';
    addAPIKey();
    this.link += '&extra=members&fields=-members_ids&clan_id=$clanId';
  }

  @override
  ClanInfo parse(List<Map<String, dynamic>> json) {
    if (json.length == 0) return null;
    final data = ClanInfo(json[0]['data']);
    return data;
  }
}