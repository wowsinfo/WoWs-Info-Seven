import 'package:wowsinfo/core/models/UI/GameServer.dart';
import 'package:wowsinfo/core/services/api/WoWsApiService.dart';

class WikiConsumableGetter extends WoWsApiService {
  WikiConsumableGetter(GameServer server) : super(server);
  @override
  String getDomainFields() => 'wows/encyclopedia/consumables/';

  @override
  String getExtraFields() => '';
}
