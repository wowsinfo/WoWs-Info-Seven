import 'package:wowsinfo/models/User/Clan.dart';

/// This is the `SearchClanResult` class
class SearchClanResult {
  List<Clan> data = [];

  SearchClanResult(List json) {
    json.forEach((item) => data.add(Clan.fromJson(item)));
  }
}
