import 'dart:convert';
import 'dart:io';

typedef JSON = Map<String, dynamic>;

/// Loads local json files to mock the API responses.
class DummyService {
  static const _jsonPath = 'test/services/json/';

  /// Loads the json file with the given [path].
  Future<JSON> _loadAsMap(String path) async {
    final file = File(path);
    final jsonString = await file.readAsString();
    // usually, we only care about the data
    return jsonDecode(jsonString)['data'];
  }

  /// Load the correct player's recent data overview.
  Future<JSON> loadGoodRecentOverview() {
    return _loadAsMap(_jsonPath + 'recent_data.json');
  }

  /// Load the null player's recent data overview.
  Future<JSON> loadEmptyRecentOverview() {
    return _loadAsMap(_jsonPath + 'recent_data_null.json');
  }

  /// Load the hidden player's recent data overview.
  Future<JSON> loadHiddenRecentOverview() {
    return _loadAsMap(_jsonPath + 'recent_data_hidden.json');
  }
}
