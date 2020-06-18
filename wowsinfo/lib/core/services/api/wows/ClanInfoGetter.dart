import 'package:wowsinfo/core/models/UI/GameServer.dart';
import 'package:wowsinfo/core/models/WoWs/ClanInfo.dart';
import 'APIParser.dart';

class ClanInfoGetter extends WoWsApiService {
  ClanInfoGetter(GameServer server, int clanId) : super(server) {
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