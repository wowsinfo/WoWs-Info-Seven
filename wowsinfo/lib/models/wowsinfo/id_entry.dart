import 'package:wowsinfo/models/encodable.dart';
import 'package:wowsinfo/models/wargaming/search_result.dart';

class IDEntry<T extends SearchResult> implements Encodable {
  const IDEntry({
    required this.entry,
    required this.server,
  });

  final T entry;
  final int server; // get from game server

  @override
  Map<String, dynamic> toJson() => {
        'entry': entry.toJson(),
        'server': server,
      };
}
