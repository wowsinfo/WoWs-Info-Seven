import 'package:wowsinfo/core/models/UI/GameServer.dart';
import 'package:wowsinfo/core/models/WoWs/BasicPlayerInfo.dart';
import 'APIParser.dart';

class BasicPlayerInfoGetter extends WoWsApiService {
  BasicPlayerInfoGetter(GameServer server, int accountId) : super(server) {
    this.link += '/wows/account/info/';
    addAPIKey();
    // Add pve, rank, solo, div2 and div3
    this.link += '&account_id=$accountId&extra=statistics.pvp_div2%2Cstatistics.pvp_div3%2Cstatistics.pvp_solo%2Cstatistics.pve%2Cstatistics.rank_solo';
  }

  @override
  BasicPlayerInfo parse(List<Map<String, dynamic>> json) {
    if (json.length == 0) return null;
    final data = BasicPlayerInfo(json[0]['data']);
    return data;
  }
}