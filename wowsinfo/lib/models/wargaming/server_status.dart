import 'package:flutter/foundation.dart';

/// Online players count of the server.

@immutable
class ServerStatus {
  const ServerStatus({
    this.wows,
  });

  final List<_PlayerOnline>? wows;

  /// Online players count of the server.
  int? get playersOnline {
    final data = wows;
    // make sure the list is not empty here
    if (data != null && data.isNotEmpty) {
      assert(data.length == 1, 'There should be only one element in it');
      return data[0].playersOnline;
    }
    return null;
  }

  factory ServerStatus.fromJson(Map<String, dynamic> json) => ServerStatus(
        wows: List<_PlayerOnline>.from(
          json['wows'].map((x) => _PlayerOnline.fromJson(x)),
        ),
      );

  Map<String, dynamic> toJson() => {
        'wows': wows == null ? null : List.from(wows!.map((x) => x.toJson())),
      };
}

@immutable
class _PlayerOnline {
  const _PlayerOnline({
    this.playersOnline,
    this.server,
  });

  final int? playersOnline;
  final String? server;

  factory _PlayerOnline.fromJson(Map<String, dynamic> json) => _PlayerOnline(
        playersOnline: json['players_online'],
        server: json['server'],
      );

  Map<String, dynamic> toJson() => {
        'players_online': playersOnline,
        'server': server,
      };
}
