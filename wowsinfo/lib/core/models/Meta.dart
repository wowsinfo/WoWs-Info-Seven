/// This is the `Meta` class, shared by all API responses from Wargaming API
class Meta {
  int count;
  int pageTotal;
  int total;
  int limit;
  int page;
  /// If the account is not _hidden, it should be null
  dynamic _hidden;
  bool get isHidden => _hidden != null;

  Meta(json) {
    this.count = json["count"];
    this.pageTotal = json["page_total"];
    this.total = json["total"];
    this.limit = json["limit"];
    this.page = json["page"];
    this._hidden = json["_hidden"];
  }
}
