import 'package:wowsinfo/core/models/User/Clan.dart';

/// This is the `SearchClanResult` class
class SearchClanResult {
  List<Clan> data;

  SearchClanResult(json) {
    this.data = json["data"];
  }
}
