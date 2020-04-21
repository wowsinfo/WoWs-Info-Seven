import 'package:wowsinfo/core/models/UI/GameServer.dart';
import 'package:wowsinfo/core/models/WoWs/RecentPlayerInfo.dart';
import 'APIParser.dart';

class RecentPlayerInfoParser extends APIParser {
  RecentPlayerInfoParser(GameServer server, int accountId) : super(server) {
    this.link += '/wows/account/statsbydate/';
    addAPIKey();
    this.link += '&account_id=$accountId&dates=20200418%2C20200417%2C20200416%2C20200415%2C20200414%2C20200413%2C20200412%2C20200411%2C20200410%2C20200409';
  }

  @override
  RecentPlayerInfo parse(List<Map<String, dynamic>> json) {
    if (json.length == 0) return null;
    final data = RecentPlayerInfo(json[0]['data']);
    return data;
  }
}