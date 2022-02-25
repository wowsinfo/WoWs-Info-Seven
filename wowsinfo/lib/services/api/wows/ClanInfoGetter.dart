import 'package:wowsinfo/models/game_server.dart';
import 'package:wowsinfo/services/api/WoWsDataProvider.dart';

class ClanInfoGetter extends WoWsDataProvider {
  final int _clanId;
  ClanInfoGetter(GameServer server, this._clanId) : super(server);

  @override
  String getDomainFields() => 'wows/clans/info/';

  @override
  String getExtraFields() =>
      '&extra=members&fields=-members_ids&clan_id=$_clanId';
}
