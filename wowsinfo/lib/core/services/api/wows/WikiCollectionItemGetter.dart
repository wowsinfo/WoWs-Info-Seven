import 'package:wowsinfo/core/models/UI/GameServer.dart';
import 'package:wowsinfo/core/services/api/WoWsDataProvider.dart';

class WikiCollectionItemGetter extends WoWsDataProvider {
  WikiCollectionItemGetter(GameServer server) : super(server);

  @override
  String getDomainFields() => '/wows/encyclopedia/collectioncards/';

  @override
  String getExtraFields() => '&fields=-tag%2C-images.large%2C-images.medium';
}
