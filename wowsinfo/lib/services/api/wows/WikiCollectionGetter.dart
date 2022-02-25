import 'package:wowsinfo/models/game_server.dart';
import 'package:wowsinfo/services/api/WoWsDataProvider.dart';

class WikiCollectionGetter extends WoWsDataProvider {
  WikiCollectionGetter(GameServer server) : super(server);

  @override
  String getDomainFields() => 'wows/encyclopedia/collections/';

  @override
  String getExtraFields() => '&fields=-card_cost%2C-tag';
}
