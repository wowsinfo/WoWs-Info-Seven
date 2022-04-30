import 'package:flutter/foundation.dart';

/// Online players count of the server.

@immutable
class ServerStatus {
  const ServerStatus({
    this.wows,
  });

  final List<ServerPlayerOnline>? wows;

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
        wows: List<ServerPlayerOnline>.from(
          json['wows'].map((x) => ServerPlayerOnline.fromJson(x)),
        ),
      );

  @override
  String toString() {
    return 'ServerStatus{online: $playersOnline}';
  }
}

@immutable
class ServerPlayerOnline {
  const ServerPlayerOnline({
    this.playersOnline,
    this.server,
  });

  final int? playersOnline;
  final String? server;

  factory ServerPlayerOnline.fromJson(Map<String, dynamic> json) =>
      ServerPlayerOnline(
        playersOnline: json['players_online'],
        server: json['server'],
      );
}
