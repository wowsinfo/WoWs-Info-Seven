import 'package:wowsinfo/core/models/UI/GameServer.dart';
import 'package:wowsinfo/core/models/WoWs/PlayerAchievement.dart';
import 'APIParser.dart';

class PlayerAchievementParser extends APIParser {
  PlayerAchievementParser(GameServer server, String accountId) : super(server) {
    this.link += '/wows/account/achievements/';
    addAPIKey();
    this.link += '&fields=battle&account_id=$accountId';
  }

  @override
  PlayerAchievement parse(List<Map<String, dynamic>> json) {
    if (json.length == 0) return null;
    final data = PlayerAchievement(json[0]['data']);
    return data;
  }
}