import 'package:wowsinfo/core/models/UI/GameServer.dart';
import 'package:wowsinfo/core/services/api/WoWsDataProvider.dart';

class SearchPlayerResultGetter extends WoWsDataProvider {
  final String _name;
  SearchPlayerResultGetter(GameServer server, this._name) : super(server);
  
  @override
  String getDomainFields() => 'wows/account/list/';

  @override
  String getExtraFields() => '&search=$_name&limit=50';
}
