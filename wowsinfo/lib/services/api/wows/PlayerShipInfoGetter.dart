import 'package:wowsinfo/core/models/UI/GameServer.dart';
import 'package:wowsinfo/core/services/api/WoWsDataProvider.dart';

class PlayerShipInfoGetter extends WoWsDataProvider {
  final int _accountId;
  String _shipId;

  /// If `shipId` is `empty`, all ships will be returned
  PlayerShipInfoGetter(GameServer server, this._accountId, {String shipId = ''})
      : super(server) {
    this._shipId = shipId;
  }

  @override
  String getDomainFields() => 'wows/ships/stats/';

  @override
  String getExtraFields() => '&account_id=$_accountId&ship_id=$_shipId';
}
