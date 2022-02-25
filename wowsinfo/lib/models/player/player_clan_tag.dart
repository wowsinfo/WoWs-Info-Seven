import 'package:wowsinfo/models/game_server.dart';
import 'package:wowsinfo/models/User/Clan.dart';
import 'package:wowsinfo/utils/Utils.dart';

/// This is the `PlayerClanTag` class
class PlayerClanTag {
  String tag;
  int clanId;

  String get tagString => '[$tag]';
  bool get hasTag => tag != null;
  Clan toClan(GameServer server) => Clan(tag, clanId, server);

  PlayerClanTag(Map<String, dynamic> data) {
    final json = data.values.first;
    this.tag = Utils.guard(json, 'clan.tag', null);
    this.clanId = Utils.guard(json, 'clan.clan_id', null);
  }
}
