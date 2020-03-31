import 'package:wowsinfo/core/Utils.dart';

/// This is the `PlayerClanTag` class
class PlayerClanTag {
  String tag;
  bool get hasTag => tag != null;

  PlayerClanTag(json, String id) {
    this.tag = Utils.guard(json, 'data.$id.clan.tag', null);
  }
}
