import 'package:flutter/foundation.dart';

/// All world of warcraft game servers.
///
/// `⚠️DO NOT CHANGE THE ORDER!!`
enum WoWsServer {
  russia,
  europe,
  northAmerica,
  asia,
}

/// The website domain of world of warships.
const _domain = ['ru', 'eu', 'com', 'asia'];

/// Prefixes wargaming uses for things like the forum.
const _prefix = ['ru', 'eu', 'na', 'asia'];

/// The website domain of wows-numbers.com.
const _numberDomain = ['ru.', '', 'na.', 'asia.'];

@immutable
class GameServer {
  GameServer(this.server);

  final WoWsServer server;

  /// The domain of the game website & API.
  late final domain = _domain[server.index];

  /// The prefix of the forum (and something else).
  late final prefix = _prefix[server.index];

  /// The domain of the wows-numbers.com.
  /// TODO: should this be here, this is not related to the GameServer though.
  late final numberDomain = _numberDomain[server.index];

  factory GameServer.fromIndex(int index) {
    if (index < 0 || index > 3) {
      throw ArgumentError('index must be between 0 and 3');
    }
    return GameServer(WoWsServer.values[index]);
  }

  static WoWsServer get defaultServer => WoWsServer.asia;
}
