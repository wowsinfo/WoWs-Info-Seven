import 'package:wowsinfo/core/models/UI/GameServer.dart';
import 'package:wowsinfo/core/models/Wiki/WikiConsumable.dart';
import 'APIParser.dart';

class WikiConsumableParser extends APIParser {
  WikiConsumableParser(GameServer server) : super(server) {
    this.link += '/wows/encyclopedia/consumables/';
    addAPIKey();
  }

  @override
  WikiConsumable parse(List<Map<String, dynamic>> json) {
    if (json.length == 0) return null;
    final first = WikiConsumable.fromJson(json.removeAt(0)['data']);
    // Merge everything
    json.forEach((element) {
      first.consumable.addAll(WikiConsumable.fromJson(element['data']).consumable);
    });
    return first;
  }
}