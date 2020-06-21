import 'package:wowsinfo/core/models/Cacheable.dart';
import 'package:wowsinfo/core/models/UI/GameServer.dart';

/// clan tag, clan id and server code
class Clan extends Cacheable {
  String tag;
  int clanId;
  GameServer server;

  String get clanIdString => '$clanId';

  Clan(this.tag, this.clanId, this.server): super(null);
  Clan.fromJson(Map<String, dynamic> json): super(json) {
    this.tag = json['tag'];
    this.clanId = json['clan_id'];
    this.server = GameServer.fromIndex(json['server']);
  }

  Map<String, dynamic> toJson() {
    return {
      'tag': tag,
      'clan_id': clanId,
      'server': server.index,
    };
  }

  @override
  bool isValid() => true;
}
