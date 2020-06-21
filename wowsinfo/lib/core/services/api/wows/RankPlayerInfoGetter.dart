import 'package:wowsinfo/core/models/UI/GameServer.dart';
import 'package:wowsinfo/core/services/api/WoWsDataProvider.dart';

class RankPlayerInfoGetter extends WoWsDataProvider {
  final int _accountId;
  RankPlayerInfoGetter(GameServer server, this._accountId) : super(server);

  @override
  String getDomainFields() => 'wows/seasons/accountinfo/';

  @override
  String getExtraFields() => '&account_id=$_accountId';
}
