import 'package:wowsinfo/core/models/UI/GameServer.dart';
import 'package:wowsinfo/core/services/api/WoWsApiService.dart';

class OnlinePlayerCountGetter extends WoWsApiService {
  OnlinePlayerCountGetter(GameServer server) : super(server);

  /// It requests to world of tank
  @override
  String getServerDomain() => 'https://api.worldoftanks.';

  @override
  String getDomainFields() => 'wgn/servers/info/';

  @override
  String getExtraFields() => '&fields=players_online&game=wows';
}
