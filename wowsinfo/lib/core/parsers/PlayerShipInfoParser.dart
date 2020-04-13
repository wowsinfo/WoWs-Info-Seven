import 'package:wowsinfo/core/data/GameServer.dart';
import 'package:wowsinfo/core/models/WoWs/PlayerShipInfo.dart';
import 'package:wowsinfo/core/parsers/APIParser.dart';

class PlayerShipInfoParser extends APIParser {
  /// If `shipId` is `empty`, all ships will be returned
  PlayerShipInfoParser(GameServer server, String accountId, {String shipId = ''}) : super(server) {
    this.link += '/wows/ships/stats/';
    addAPIKey();
    this.link += '&account_id=$accountId&ship_id=$shipId';
  }

  @override
  PlayerShipInfo parse(List<Map<String, dynamic>> json) {
    if (json.length == 0) return null;
    final data = PlayerShipInfo(json[0]['data']);
    return data;
  }
}