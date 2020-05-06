import 'package:wowsinfo/core/models/UI/GameServer.dart';
import 'package:wowsinfo/core/models/Wiki/WikiEncyclopedia.dart';
import 'APIParser.dart';

class WikiEncyclopediaParser extends APIParser {
  WikiEncyclopediaParser(GameServer server) : super(server) {
    this.link += '/wows/encyclopedia/info/';
    addAPIKey();
    this.link += '&fields=-ship_type_images.image_elite,-ship_modifications,-ships_updated_at';
  }

  @override
  WikiEncyclopedia parse(List<Map<String, dynamic>> json) {
    if (json.length == 0) return null;
    final info = WikiEncyclopedia.fromJson(json[0]['data']);
    return info;
  }
}