import 'package:wowsinfo/core/data/GameServer.dart';
import 'package:wowsinfo/core/models/WoWs/SearchClanResult.dart';
import 'package:wowsinfo/core/parsers/APIParser.dart';

class SearchClanResultParser extends APIParser {
  SearchClanResultParser(GameServer server, String tag) : super(server) {
    this.link += '/wows/clans/list/';
    addAPIKey();
    this.link += '&fields=clan_id%2Ctag&search=$tag';
  }

  @override
  SearchClanResult parse(List<Map<String, dynamic>> json) {
    if (json.length == 0) return null;
    final data = SearchClanResult(json[0]['data']);
    return data;
  }
}