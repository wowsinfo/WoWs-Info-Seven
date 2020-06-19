import 'package:wowsinfo/core/models/UI/GameServer.dart';
import 'package:wowsinfo/core/services/api/WoWsApiService.dart';

class AccountCreatedAtGetter extends WoWsApiService {
  final String _player;
  AccountCreatedAtGetter(GameServer server, this._player) : super(server);

  @override
  String getDomainFields() => 'wgn/account/list/';

  @override
  String getExtraFields() => '&fields=created_at&search=$_player';
}
