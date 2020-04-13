import 'package:wowsinfo/core/data/GameServer.dart';
import 'package:wowsinfo/core/models/Wiki/WikiWarship.dart';

import 'APIParser.dart';

class WikiWarshipParser extends APIParser {
  WikiWarshipParser(GameServer server) : super(server) {
    this.link += '/wows/encyclopedia/ships/';
    addAPIKey();
  }

  @override
  WikiWarship parse(List<Map<String, dynamic>> json) {
    final first = WikiWarship.fromJson(json.removeAt(0)['data']);
    // Merge everything
    json.forEach((element) {
      first.ships.addAll(WikiWarship.fromJson(element['data']).ships);
    });
    return first;
  }
}
