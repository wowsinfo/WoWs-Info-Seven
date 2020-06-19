import 'package:wowsinfo/core/models/UI/GameServer.dart';
import 'package:wowsinfo/core/services/api/WoWsApiService.dart';

class RankPlayerShipInfoGetter extends WoWsApiService {
  final int _accountId;
  RankPlayerShipInfoGetter(GameServer server, this._accountId) : super(server);

  @override
  String getDomainFields() => 'wows/seasons/shipstats/';

  @override
  String getExtraFields() => '&account_id=$_accountId';
}
