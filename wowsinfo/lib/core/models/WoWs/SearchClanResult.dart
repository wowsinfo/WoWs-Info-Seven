/// This is the `SearchClanResult` class
class SearchClanResult {
  List<Clan> data;

  SearchClanResult(json) {
    this.data = json["data"];
  }
}

/// This is the `Data` class
class Clan {
  int clanId;
  String tag;

  Clan(json) {
    this.clanId = json["clan_id"];
    this.tag = json["tag"];
  }
}