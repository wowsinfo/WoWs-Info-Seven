import 'package:wowsinfo/core/models/UI/GameServer.dart';
import 'package:wowsinfo/core/services/api/WoWsApiService.dart';

class ClanInfoGetter extends WoWsApiService {
  final int _clanId;
  ClanInfoGetter(GameServer server, this._clanId) : super(server);

  @override
  String getDomainFields() => 'wows/clans/info/';

  @override
  String getExtraFields() =>
      '&extra=members&fields=-members_ids&clan_id=$_clanId';
}
