import 'package:wowsinfo/core/models/UI/GameServer.dart';
import 'package:wowsinfo/core/models/WoWs/RankPlayerInfo.dart';
import 'APIParser.dart';

class RankPlayerInfoGetter extends WoWsApiService {
  RankPlayerInfoGetter(GameServer server, int accountId) : super(server) {
    this.link += '/wows/seasons/accountinfo/';
    addAPIKey();
    this.link += '&account_id=$accountId';
  }

  @override
  RankPlayerInfo parse(List<Map<String, dynamic>> json) {
    if (json.length == 0) return null;
    final data = RankPlayerInfo(json[0]['data']);
    return data;
  }
}