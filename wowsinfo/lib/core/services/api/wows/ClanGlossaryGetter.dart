import 'package:wowsinfo/core/models/UI/GameServer.dart';
import 'package:wowsinfo/core/services/api/WoWsApiService.dart';

class ClanGlossaryGetter extends WoWsApiService {
  ClanGlossaryGetter(GameServer server) : super(server);

  @override
  String getDomainFields() => 'wows/clans/glossary/';

  @override
  String getExtraFields() => '&fields=clans_roles';
}
