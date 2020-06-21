import 'package:wowsinfo/core/models/UI/GameServer.dart';
import 'package:wowsinfo/core/services/api/WoWsDataProvider.dart';

class WikiCollectionGetter extends WoWsDataProvider {
  WikiCollectionGetter(GameServer server) : super(server);

  @override
  String getDomainFields() => 'wows/encyclopedia/collections/';

  @override
  String getExtraFields() => '&fields=-card_cost%2C-tag';
}
