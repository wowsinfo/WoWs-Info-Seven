import 'package:wowsinfo/core/Utils.dart';

/// This is the `OnlinePlayerCount` class
class OnlinePlayerCount {
  int count;
  bool get isOK => count >= 0;

  OnlinePlayerCount(json) {
    this.count = Utils.guard(json, 'data.wows.0.players_online', -1);
  }
}
