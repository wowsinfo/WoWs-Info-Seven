import 'package:wowsinfo/models/game_server.dart';
import 'package:wowsinfo/services/api/WoWsDataProvider.dart';

class WikiGameMapGetter extends WoWsDataProvider {
  WikiGameMapGetter(GameServer server) : super(server);

  @override
  String getDomainFields() => 'wows/encyclopedia/battlearenas/';

  @override
  String getExtraFields() => '&fields=-battle_arena_id';
}
