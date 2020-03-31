/// This is the `AccountCreatedAt` class
class AccountCreatedAt {
  List<Data> data;

  AccountCreatedAt(json) {
    this.data = json["data"];
  }
}

/// This is the `Data` class
class Data {
  int createdAt;

  Data(json) {
    this.createdAt = json["created_at"];
  }
}
