import 'package:wowsinfo/core/data/GameServer.dart';
import 'package:wowsinfo/core/models/WoWs/PlayerClanTag.dart';
import 'package:wowsinfo/core/parsers/APIParser.dart';

class PlayerClanTagParser extends APIParser {
  PlayerClanTagParser(GameServer server, String accountId) : super(server) {
    this.link += '/wows/clans/accountinfo/';
    addAPIKey();
    this.link += '&extra=clan&fields=clan.tag&account_id=$accountId';
  }

  @override
  PlayerClanTag parse(List<Map<String, dynamic>> json) {
    if (json.length == 0) return null;
    final data = PlayerClanTag(json[0]['data']);
    return data;
  }
}