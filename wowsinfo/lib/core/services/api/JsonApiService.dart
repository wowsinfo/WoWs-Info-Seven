import 'package:wowsinfo/core/services/api/BaseApiService.dart';

abstract class JsonApiService extends BaseApiService<String> {
  @override
  Future<String> requestData() {
    throw UnimplementedError();
  }
}