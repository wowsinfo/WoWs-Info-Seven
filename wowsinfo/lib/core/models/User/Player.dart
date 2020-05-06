import 'package:wowsinfo/core/data/Preference.dart';
import 'package:wowsinfo/core/models/UI/GameServer.dart';

/// player nickname, account id and server code
class Player {
  String nickname;
  int playerId;
  GameServer server;

  String get playerIdString => '$playerId';

  Player(this.nickname, this.playerId) {
    // Server will be automatically set
    server = Preference.shared.gameServer;
  }

  Player.fromJson(Map<String, dynamic> json) {
    this.nickname = json['nickname'];
    this.playerId = json['account_id'];
    // Use current server index, comment this line while testing
    if (json['server'] == null) this.server = Preference.shared.gameServer;
    else this.server = GameServer.fromIndex(json['server']);
  }

  Map<String, dynamic> toJson() {
    return {
      'nickname': nickname,
      'account_id': playerId,
      'server': server.index,
    };
  }
}