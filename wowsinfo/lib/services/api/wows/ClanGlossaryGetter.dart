import 'package:wowsinfo/models/game_server.dart';
import 'package:wowsinfo/services/api/WoWsDataProvider.dart';

class ClanGlossaryGetter extends WoWsDataProvider {
  ClanGlossaryGetter(GameServer server) : super(server);

  @override
  String getDomainFields() => 'wows/clans/glossary/';

  @override
  String getExtraFields() => '&fields=clans_roles';
}
