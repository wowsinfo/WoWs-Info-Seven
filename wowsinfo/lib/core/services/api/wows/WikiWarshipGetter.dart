import 'package:wowsinfo/core/models/UI/GameServer.dart';
import 'package:wowsinfo/core/services/api/WoWsDataProvider.dart';

class WikiWarshipGetter extends WoWsDataProvider {
  WikiWarshipGetter(GameServer server) : super(server);
  @override
  String getDomainFields() => 'wows/encyclopedia/ships/';

  @override
  String getExtraFields() => '';
}
