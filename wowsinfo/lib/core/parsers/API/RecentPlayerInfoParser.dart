import 'package:wowsinfo/core/models/UI/GameServer.dart';
import 'package:wowsinfo/core/models/WoWs/RecentPlayerInfo.dart';
import 'APIParser.dart';

class RecentPlayerInfoParser extends APIParser {
  RecentPlayerInfoParser(GameServer server, int accountId) : super(server) {
    this.link += '/wows/account/statsbydate/';
    addAPIKey();
    this.link += '&account_id=$accountId&dates=20200420%2C20200419%2C20200418%2C20200417%2C20200416';
  }

  @override
  RecentPlayerInfo parse(List<Map<String, dynamic>> json) {
    if (json.length == 0) return null;
    final data = RecentPlayerInfo(json[0]['data']);
    return data;
  }
}