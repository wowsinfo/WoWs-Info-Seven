import 'package:wowsinfo/core/models/UI/GameServer.dart';
import 'package:wowsinfo/core/models/Wiki/WikiCollection.dart';
import 'APIParser.dart';

class WikiCollectionGetter extends WoWsApiService {
  WikiCollectionGetter(GameServer server) : super(server) {
    this.link += '/wows/encyclopedia/collections/';
    addAPIKey();
    this.link += '&fields=-card_cost%2C-tag';
  }

  @override
  WikiCollection parse(List<Map<String, dynamic>> json) {
    if (json.length == 0) return null;
    final first = WikiCollection.fromJson(json.removeAt(0)['data']);
    // Merge everything
    json.forEach((element) {
      first.collection.addAll(WikiCollection.fromJson(element['data']).collection);
    });
    return first;
  }
}