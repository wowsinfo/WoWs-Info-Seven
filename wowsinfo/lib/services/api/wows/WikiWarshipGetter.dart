import 'package:wowsinfo/models/game_server.dart';
import 'package:wowsinfo/services/api/WoWsDataProvider.dart';

class WikiWarshipGetter extends WoWsDataProvider {
  WikiWarshipGetter(GameServer server) : super(server);
  @override
  String getDomainFields() => 'wows/encyclopedia/ships/';

  @override
  String getExtraFields() => '';
}
