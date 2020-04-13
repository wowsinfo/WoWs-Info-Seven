import 'package:wowsinfo/core/others/Utils.dart';

/// This is the `PlayerClanTag` class
class PlayerClanTag {
  String tag;
  bool get hasTag => tag != null;

  PlayerClanTag(Map<String, dynamic> data) {
    final json = data.values.first;
    this.tag = Utils.guard(json, 'clan.tag', null);
  }
}
