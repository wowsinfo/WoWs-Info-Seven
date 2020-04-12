import 'package:wowsinfo/core/data/Preference.dart';

/// player nickname, account id and server code
class Player {
  String nickname;
  int playerId;
  int server;

  Player(this.nickname, this.playerId, this.server);

  Player.fromJson(Map<String, dynamic> json) {
    this.nickname = json['nickname'];
    this.playerId = json['account_id'];
    // Use current server index, comment this line while testing
    this.server = Preference.shared.gameServer;
  }

  Map<String, dynamic> toJson() {
    return {
      'nickname': nickname,
      'account_id': playerId,
      'server': server,
    };
  }
}