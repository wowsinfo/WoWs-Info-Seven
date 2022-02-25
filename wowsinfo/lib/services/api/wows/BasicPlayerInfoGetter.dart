import 'package:wowsinfo/models/game_server.dart';
import 'package:wowsinfo/services/api/WoWsDataProvider.dart';

class BasicPlayerInfoGetter extends WoWsDataProvider {
  final int _accountId;
  BasicPlayerInfoGetter(GameServer server, this._accountId) : super(server);

  @override
  String getDomainFields() => 'wows/account/info/';

  @override
  String getExtraFields() =>
      '&account_id=$_accountId&extra=statistics.pvp_div2%2Cstatistics.pvp_div3%2Cstatistics.pvp_solo%2Cstatistics.pve%2Cstatistics.rank_solo';
}
