/// Data provider provides data for certain type
abstract class BaseDataProvider<T> {
  /// An optional creator can be pased to create `T`
  Future<T> requestData({T Function(dynamic) creator});
}
