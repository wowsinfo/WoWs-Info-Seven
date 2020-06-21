import 'package:wowsinfo/core/models/UI/GameServer.dart';
import 'package:wowsinfo/core/services/api/WoWsDataProvider.dart';

class PlayerAchievementGetter extends WoWsDataProvider {
  final int _accountId;
  PlayerAchievementGetter(GameServer server, this._accountId) : super(server);

  @override
  String getDomainFields() => 'wows/account/achievements/';

  @override
  String getExtraFields() => '&fields=battle&account_id=$_accountId';
}
