import 'package:wowsinfo/models/game_server.dart';
import 'package:wowsinfo/services/api/WoWsDataProvider.dart';

class OnlinePlayerCountGetter extends WoWsDataProvider {
  OnlinePlayerCountGetter(GameServer server) : super(server);

  /// It requests to world of tank
  @override
  String getServerDomain() => 'https://api.worldoftanks.';

  @override
  String getDomainFields() => 'wgn/servers/info/';

  @override
  String getExtraFields() => '&fields=players_online&game=wows';
}
