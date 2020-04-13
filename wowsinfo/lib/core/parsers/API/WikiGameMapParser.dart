import 'package:wowsinfo/core/data/GameServer.dart';
import 'package:wowsinfo/core/models/Wiki/WikiGameMap.dart';
import 'APIParser.dart';

class WikiGameMapParser extends APIParser {
  WikiGameMapParser(GameServer server) : super(server) {
    this.link += '/wows/encyclopedia/battlearenas/';
    addAPIKey();
    this.link += '&fields=-battle_arena_id';
  }

  @override
  WikiGameMap parse(List<Map<String, dynamic>> json) {
    if (json.length == 0) return null;
    final first = WikiGameMap.fromJson(json.removeAt(0)['data']);
    // Merge everything
    json.forEach((element) {
      first.gameMap.addAll(WikiGameMap.fromJson(element['data']).gameMap);
    });
    return first;
  }
}