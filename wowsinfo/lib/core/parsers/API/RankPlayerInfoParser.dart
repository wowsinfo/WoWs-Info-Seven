import 'package:wowsinfo/core/data/GameServer.dart';
import 'package:wowsinfo/core/models/WoWs/RankPlayerInfo.dart';
import 'APIParser.dart';

class RankPlayerInfoParser extends APIParser {
  RankPlayerInfoParser(GameServer server, String accountId) : super(server) {
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