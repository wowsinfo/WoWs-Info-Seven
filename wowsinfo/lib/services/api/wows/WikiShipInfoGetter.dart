import 'package:wowsinfo/models/game_server.dart';
import 'package:wowsinfo/services/api/WoWsDataProvider.dart';

class WikiShipInfoGetter extends WoWsDataProvider {
  final int _shipId;
  WikiShipInfoGetter(GameServer server, this._shipId) : super(server);

  @override
  String getDomainFields() => 'wows/encyclopedia/ships/';

  @override
  String getExtraFields() => '&ship_id=$_shipId';
}
