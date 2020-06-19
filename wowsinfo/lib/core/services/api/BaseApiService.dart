/// This gets data via API or something similar
abstract class BaseApiService<T> {
  // Request data from API (or some other data providers)
  Future<T> requestData();
  // The address of the link, usually made of a base link and extra fields
  String getRequestLink() => getBaseLink() + getExtraFields();
  String getBaseLink();
  String getExtraFields();
}
