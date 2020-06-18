import 'package:wowsinfo/core/models/UI/GameServer.dart';
import 'package:wowsinfo/core/models/UI/RecentDate.dart';
import 'package:wowsinfo/core/models/WoWs/RecentPlayerInfo.dart';
import 'APIParser.dart';

class RecentPlayerInfoGetter extends WoWsApiService {
  RecentPlayerInfoGetter(GameServer server, int accountId) : super(server) {
    this.link += '/wows/account/statsbydate/';
    addAPIKey();
    final recent = RecentDate();
    this.link += '&account_id=$accountId&dates=${recent.tenDayString}';
  }

  @override
  RecentPlayerInfo parse(List<Map<String, dynamic>> json) {
    if (json.length == 0) return null;
    final data = RecentPlayerInfo(json[0]['data']);
    return data;
  }
}