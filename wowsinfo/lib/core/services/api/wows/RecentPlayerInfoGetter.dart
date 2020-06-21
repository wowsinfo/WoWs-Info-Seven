import 'package:wowsinfo/core/models/UI/GameServer.dart';
import 'package:wowsinfo/core/models/UI/RecentDate.dart';
import 'package:wowsinfo/core/services/api/WoWsDataProvider.dart';

class RecentPlayerInfoGetter extends WoWsDataProvider {
  final int _accountId;
  RecentPlayerInfoGetter(GameServer server, this._accountId) : super(server);

  @override
  String getDomainFields() => 'wows/account/statsbydate/';

  /// Get recent 10 days, I think API only supports up to ten days per request
  @override
  String getExtraFields() => '&account_id=$_accountId&dates=${RecentDate.getRecentDateString(length: 10)}';
}
