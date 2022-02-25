import 'package:wowsinfo/models/game_server.dart';
import 'package:wowsinfo/services/api/WoWsDataProvider.dart';

class SearchClanResultGetter extends WoWsDataProvider {
  final String _tag;
  SearchClanResultGetter(GameServer server, this._tag) : super(server);

  @override
  String getDomainFields() => 'wows/clans/list/';

  /// Here the limit is 10 because there will usually be more clans than players
  @override
  String getExtraFields() => '&fields=clan_id%2Ctag&search=$_tag&limit=10';
}
