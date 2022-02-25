import 'package:wowsinfo/models/game_server.dart';
import 'package:wowsinfo/services/api/WoWsDataProvider.dart';

class SearchPlayerResultGetter extends WoWsDataProvider {
  final String _name;
  SearchPlayerResultGetter(GameServer server, this._name) : super(server);

  @override
  String getDomainFields() => 'wows/account/list/';

  @override
  String getExtraFields() => '&search=$_name&limit=50';
}
