import 'package:wowsinfo/core/models/UI/GameServer.dart';
import 'package:wowsinfo/core/models/WoWs/SearchClanResult.dart';
import 'APIParser.dart';

class SearchClanResultGetter extends WoWsApiService {
  SearchClanResultGetter(GameServer server, String tag) : super(server) {
    this.link += '/wows/clans/list/';
    addAPIKey();
    this.link += '&fields=clan_id%2Ctag&search=$tag&limit=10';
  }

  @override
  SearchClanResult parse(List<Map<String, dynamic>> json) {
    if (json.length == 0) return null;
    final data = SearchClanResult(json[0]['data']);
    return data;
  }
}