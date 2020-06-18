/// This gets data via API or something similar
abstract class BaseApiService<T> {
  // Request data from API (or some other data providers)
  Future<T> requestData();
  // The address of the link
  String getRequestLink();
}
