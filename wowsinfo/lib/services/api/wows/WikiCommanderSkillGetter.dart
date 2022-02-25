import 'package:wowsinfo/models/game_server.dart';
import 'package:wowsinfo/services/api/WoWsDataProvider.dart';

class WikiCommanderSkillGetter extends WoWsDataProvider {
  WikiCommanderSkillGetter(GameServer server) : super(server);

  @override
  String getDomainFields() => 'wows/encyclopedia/crewskills/';

  @override
  String getExtraFields() => '';
}
