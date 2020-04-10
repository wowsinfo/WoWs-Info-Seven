import 'package:wowsinfo/core/models/User/Player.dart';

/// This is the `SearchPlayerResult` class
class SearchPlayerResult {
  List<Player> data;

  SearchPlayerResult(json) {
    this.data = json["data"];
  }
}
