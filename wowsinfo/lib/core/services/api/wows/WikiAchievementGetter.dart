import 'package:wowsinfo/core/models/UI/GameServer.dart';
import 'package:wowsinfo/core/services/api/WoWsApiService.dart';

class WikiAchievementGetter extends WoWsApiService {
  WikiAchievementGetter(GameServer server) : super(server);

  @override
  String getDomainFields() => 'wows/encyclopedia/achievements/';

  @override
  String getExtraFields() =>
      '&fields=battle.hidden%2Cbattle.achievement_id%2Cbattle.name%2Cbattle.image%2Cbattle.image_inactive%2Cbattle.description';
}
