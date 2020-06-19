import 'package:wowsinfo/core/models/UI/GameServer.dart';
import 'package:wowsinfo/core/services/api/WoWsApiService.dart';

class SearchPlayerResultGetter extends WoWsApiService {
  final String _name;
  SearchPlayerResultGetter(GameServer server, this._name) : super(server);
  
  @override
  String getDomainFields() => 'wows/account/list/';

  @override
  String getExtraFields() => '&search=$_name&limit=50';
}
