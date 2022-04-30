/// Wargaming API error with additional information
///
/// This is included only if something goes wrong.
/// It can be used to validate the response.
/// TODO: we can potentially ignore all the fields here because they are not used.
class WargamingAPIError {
  String? field;
  String? message;
  int? code;
  String? value;

  WargamingAPIError.fromJson(Map<String, dynamic> json) {
    field = json['field'] as String?;
    message = json['message'] as String?;
    code = json['code'] as int?;
    value = json['value'] as String?;
  }

  @override
  String toString() {
    return 'WargamingAPIError{field: $field, message: $message, code: $code, value: $value}';
  }
}

/// Wargaming API meta data
///
/// Some APIs may have multiple pages so this is provided to help with pagination.
/// Pagination is required if pageTotal is provided.
class WargamingAPIMeta {
  int? count;
  int? pageTotal;
  int? total;
  int? limit; // by default 100
  int? page;

  /// Check if there are multiple pages available.
  bool get requirePagination => pageTotal != null && pageTotal! > 1;

  /// Check if there are more pages available.
  bool get hasMorePages {
    return pageTotal != null && page != null && page! < pageTotal!;
  }

  WargamingAPIMeta.fromJson(Map<String, dynamic> json) {
    count = json['count'] as int?;
    pageTotal = json['page_total'] as int?;
    total = json['total'] as int?;
    limit = json['limit'] as int?;
    page = json['page'] as int?;
  }

  @override
  String toString() {
    return 'WargamingAPIMeta{count: $count, pageTotal: $pageTotal, total: $total, limit: $limit, page: $page}';
  }
}
