import 'package:wowsinfo/core/models/UI/GameServer.dart';
import 'package:wowsinfo/core/models/WoWs/WikiShipInfo.dart';
import 'APIParser.dart';

class WikiShipInfoGetter extends WoWsApiService {
  WikiShipInfoGetter(GameServer server, int shipId) : super(server) {
    this.link += '/wows/encyclopedia/ships/';
    addAPIKey();
    this.link += '&ship_id=$shipId';
  }

  @override
  WikiShipInfo parse(List<Map<String, dynamic>> json) {
    if (json.length == 0) return null;
    final data = WikiShipInfo(json[0]['data']);
    return data;
  }
}