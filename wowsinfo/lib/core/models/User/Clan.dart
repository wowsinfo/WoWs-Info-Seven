import 'package:wowsinfo/core/data/Preference.dart';
import 'package:wowsinfo/core/models/UI/GameServer.dart';

/// clan tag, clan id and server code
class Clan {
  String tag;
  int clanId;
  GameServer server;

  String get clanIdString => '$clanId';

  Clan(this.tag, this.clanId) {
    server = Preference.shared.gameServer;
  }

  Clan.fromJson(Map<String, dynamic> json) {
    this.tag = json['tag'];
    this.clanId = json['clan_id'];
    if (json['server'] == null) this.server = Preference.shared.gameServer;
    else this.server = GameServer.fromIndex(json['server']);
  }

  Map<String, dynamic> toJson() {
    return {
      'tag': tag,
      'clan_id': clanId,
      'server': server.index,
    };
  }
}