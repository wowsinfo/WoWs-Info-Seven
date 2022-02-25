import 'package:wowsinfo/models/game_server.dart';
import 'package:wowsinfo/services/api/WoWsDataProvider.dart';

class WikiCollectionItemGetter extends WoWsDataProvider {
  WikiCollectionItemGetter(GameServer server) : super(server);

  @override
  String getDomainFields() => '/wows/encyclopedia/collectioncards/';

  @override
  String getExtraFields() => '&fields=-tag%2C-images.large%2C-images.medium';
}
