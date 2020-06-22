import 'package:wowsinfo/core/models/UI/GameServer.dart';
import 'package:wowsinfo/core/services/api/WoWsDataProvider.dart';

class WikiConsumableGetter extends WoWsDataProvider {
  WikiConsumableGetter(GameServer server) : super(server);
  @override
  String getDomainFields() => 'wows/encyclopedia/consumables/';

  @override
  String getExtraFields() => '';
}
