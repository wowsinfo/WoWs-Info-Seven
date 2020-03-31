/// This is the `SearchPlayerResult` class
class SearchPlayerResult {
  List<Data> data;

  SearchPlayerResult(json) {
    this.data = json["data"];
  }
}

/// This is the `Data` class
class Data {
  String nickname;
  int accountId;

  Data(json) {
    this.nickname = json["nickname"];
    this.accountId = json["account_id"];
  }
}