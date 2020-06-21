import 'package:wowsinfo/core/models/UI/GameServer.dart';
import 'package:wowsinfo/core/services/api/WoWsDataProvider.dart';

class WikiCommanderSkillGetter extends WoWsDataProvider {
  WikiCommanderSkillGetter(GameServer server) : super(server);

  @override
  String getDomainFields() => 'wows/encyclopedia/crewskills/';

  @override
  String getExtraFields() => '';
}
