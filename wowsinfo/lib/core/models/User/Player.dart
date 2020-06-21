import 'package:wowsinfo/core/models/Cacheable.dart';
import 'package:wowsinfo/core/models/UI/GameServer.dart';

/// player nickname, account id and server code
class Player extends Cacheable {
  String nickname;
  int playerId;
  GameServer server;

  String get playerIdString => '$playerId';

  Player(this.nickname, this.playerId, this.server) : super(null);
  Player.fromJson(Map<String, dynamic> json): super(json) {
    this.nickname = json['nickname'];
    this.playerId = json['account_id'];
    this.server = GameServer.fromIndex(json['server']);
  }

  Map<String, dynamic> toJson() {
    return {
      'nickname': nickname,
      'account_id': playerId,
      'server': server.index,
    };
  }

  @override
  bool isValid() => true;
}
