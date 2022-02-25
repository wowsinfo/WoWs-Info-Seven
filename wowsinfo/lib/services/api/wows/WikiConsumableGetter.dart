import 'package:wowsinfo/models/game_server.dart';
import 'package:wowsinfo/services/api/WoWsDataProvider.dart';

class WikiConsumableGetter extends WoWsDataProvider {
  WikiConsumableGetter(GameServer server) : super(server);
  @override
  String getDomainFields() => 'wows/encyclopedia/consumables/';

  @override
  String getExtraFields() => '';
}
