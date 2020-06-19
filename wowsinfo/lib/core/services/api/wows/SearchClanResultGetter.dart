import 'package:wowsinfo/core/models/UI/GameServer.dart';
import 'package:wowsinfo/core/services/api/WoWsApiService.dart';

class SearchClanResultGetter extends WoWsApiService {
  final String _tag;
  SearchClanResultGetter(GameServer server, this._tag) : super(server);

  @override
  String getDomainFields() => 'wows/clans/list/';

  /// Here the limit is 10 because there will usually be more clans than players
  @override
  String getExtraFields() => '&fields=clan_id%2Ctag&search=$_tag&limit=10';
}