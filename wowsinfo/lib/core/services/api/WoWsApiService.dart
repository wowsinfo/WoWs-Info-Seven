import 'package:wowsinfo/core/services/api/BaseApiService.dart';
import 'package:wowsinfo/core/services/api/key.dart';

/// Wargmaing API is a bit complicated. Often, it needs an api key, data language and some fields
/// - Paging is necessary sometimes
/// - It returns a list of string
abstract class WoWsApiService extends BaseApiService<List<String>> {
  int _pageNumber = 0;
  bool _hasMorePage = true;

  /// Make sure `key.dart` contains the key
  String getApiKeyField() => '?application_id=$API_KEY';

  @override
  Future<List<String>> requestData() async {
    throw UnimplementedError();
  }
}
