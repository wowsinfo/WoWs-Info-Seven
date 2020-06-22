import 'package:wowsinfo/core/models/UI/GameServer.dart';
import 'package:wowsinfo/core/services/api/WoWsDataProvider.dart';

class WikiShipInfoGetter extends WoWsDataProvider {
  final int _shipId;
  WikiShipInfoGetter(GameServer server, this._shipId) : super(server);

  @override
  String getDomainFields() => 'wows/encyclopedia/ships/';

  @override
  String getExtraFields() => '&ship_id=$_shipId';
}
