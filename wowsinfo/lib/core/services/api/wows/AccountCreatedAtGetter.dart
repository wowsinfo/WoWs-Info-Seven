import 'package:wowsinfo/core/models/UI/GameServer.dart';
import 'package:wowsinfo/core/services/api/WoWsApiService.dart';

class AccountCreatedAtGetter extends WoWsApiService {
  AccountCreatedAtGetter(GameServer server, String player) {
    this.link += '/wgn/account/list/';
    this.link += '&fields=created_at&search=$player';
  }

  @override
  String getRequestLink() {
    // TODO: implement getRequestLink
    throw UnimplementedError();
  }
}