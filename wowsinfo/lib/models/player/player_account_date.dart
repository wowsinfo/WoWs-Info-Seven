/// This is the `AccountCreatedDate` class
class AccountCreatedDate {
  List<Data> data;

  AccountCreatedDate(json) {
    this.data = json['data'];
  }
}

/// This is the `Data` class
class Data {
  int createdAt;

  Data(json) {
    this.createdAt = json['created_at'];
  }
}
