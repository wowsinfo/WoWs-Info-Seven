import 'package:wowsinfo/core/data/Preference.dart';
import 'package:wowsinfo/core/models/User/Clan.dart';
import 'package:wowsinfo/core/others/Utils.dart';

/// This is the `PlayerClanTag` class
class PlayerClanTag {
  String tag;
  int clanId;

  String get tagString => '[$tag]';
  bool get hasTag => tag != null;
  Clan toClan(Preference pref) => Clan(tag, clanId, pref.gameServer);

  PlayerClanTag(Map<String, dynamic> data) {
    final json = data.values.first;
    this.tag = Utils.guard(json, 'clan.tag', null);
    this.clanId = Utils.guard(json, 'clan.clan_id', null);
  }
}
