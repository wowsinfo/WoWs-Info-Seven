import 'package:wowsinfo/core/models/UI/GameServer.dart';
import 'package:wowsinfo/core/services/api/WoWsDataProvider.dart';

class ClanGlossaryGetter extends WoWsDataProvider {
  ClanGlossaryGetter(GameServer server) : super(server);

  @override
  String getDomainFields() => 'wows/clans/glossary/';

  @override
  String getExtraFields() => '&fields=clans_roles';
}
