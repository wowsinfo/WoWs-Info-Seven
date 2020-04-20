import 'package:wowsinfo/core/models/UI/GameServer.dart';
import 'package:wowsinfo/core/models/WoWs/PlayerClanTag.dart';
import 'APIParser.dart';

class PlayerClanTagParser extends APIParser {
  PlayerClanTagParser(GameServer server, int accountId) : super(server) {
    this.link += '/wows/clans/accountinfo/';
    addAPIKey();
    this.link += '&extra=clan&fields=clan.tag,clan.clan_id&account_id=$accountId';
  }

  @override
  PlayerClanTag parse(List<Map<String, dynamic>> json) {
    if (json.length == 0) return null;
    final data = PlayerClanTag(json[0]['data']);
    return data;
  }
}