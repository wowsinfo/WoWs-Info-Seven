import 'package:wowsinfo/core/models/UI/GameServer.dart';
import 'package:wowsinfo/core/services/api/WoWsApiService.dart';

class WikiEncyclopediaGetter extends WoWsApiService {
  WikiEncyclopediaGetter(GameServer server) : super(server);

  @override
  String getDomainFields() => 'wows/encyclopedia/info/';

  @override
  String getExtraFields() =>
      '&fields=-ship_type_images.image_elite,-ship_modifications,-ships_updated_at';
}
