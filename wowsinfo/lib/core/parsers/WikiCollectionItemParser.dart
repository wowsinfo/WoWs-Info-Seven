import 'package:wowsinfo/core/data/GameServer.dart';
import 'package:wowsinfo/core/models/Wiki/WikiCollectionItem.dart';
import 'package:wowsinfo/core/parsers/APIParser.dart';

class WikiCollectionItemParser extends APIParser {
  WikiCollectionItemParser(GameServer server) : super(server) {
    this.link += '/wows/encyclopedia/collectioncards/';
    addAPIKey();
    this.link += '&fields=-tag%2C-images.large%2C-images.medium';
  }

  @override
  WikiCollectionItem parse(List<Map<String, dynamic>> json) {
    if (json.length == 0) return null;
    final first = WikiCollectionItem.fromJson(json.removeAt(0)['data']);
    // Merge everything
    json.forEach((element) {
      first.item.addAll(WikiCollectionItem.fromJson(element['data']).item);
    });
    return first;
  }
}