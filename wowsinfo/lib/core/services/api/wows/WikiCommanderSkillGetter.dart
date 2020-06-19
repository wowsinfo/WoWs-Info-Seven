import 'package:wowsinfo/core/models/UI/GameServer.dart';
import 'package:wowsinfo/core/services/api/WoWsApiService.dart';

class WikiCommanderSkillGetter extends WoWsApiService {
  WikiCommanderSkillGetter(GameServer server) : super(server);

  @override
  String getDomainFields() => 'wows/encyclopedia/crewskills/';

  @override
  String getExtraFields() => '';
}
