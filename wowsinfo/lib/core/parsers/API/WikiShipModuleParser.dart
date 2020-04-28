import 'package:wowsinfo/core/models/UI/GameServer.dart';
import 'package:wowsinfo/core/models/WoWs/WikiShipModule.dart';

import 'APIParser.dart';

class WikiShipModuleParser extends APIParser {
  String _id;

  WikiShipModuleParser(GameServer server, int shipId) : super(server) {
    this._id = shipId.toString();
    this.link += '/wows/encyclopedia/shipprofile/';
    addAPIKey();
    this.link += '&ship_id=$_id';
  }

  @override
  WikiShipModule parse(List<Map<String, dynamic>> json) {
    if (json.length == 0) return null;
    final first = WikiShipModule(json[0]['data'][_id]);
    return first;
  }
}
