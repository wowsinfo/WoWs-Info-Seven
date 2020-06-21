/// Data provider provides data for certain type
abstract class BaseDataProvider<T> {
  Future<T> requestData();
}
