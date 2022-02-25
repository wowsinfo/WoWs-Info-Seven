import 'package:wowsinfo/models/game_server.dart';
import 'package:wowsinfo/services/api/WoWsDataProvider.dart';

class AccountCreatedAtGetter extends WoWsDataProvider {
  final String _player;
  AccountCreatedAtGetter(GameServer server, this._player) : super(server);

  @override
  String getDomainFields() => 'wgn/account/list/';

  @override
  String getExtraFields() => '&fields=created_at&search=$_player';
}
