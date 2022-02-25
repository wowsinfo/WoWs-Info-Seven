import 'package:wowsinfo/models/User/Player.dart';

/// This is the `SearchPlayerResult` class
class SearchPlayerResult {
  List<Player> players = [];

  SearchPlayerResult(List json) {
    json.forEach((item) => players.add(Player.fromJson(item)));
  }
}
