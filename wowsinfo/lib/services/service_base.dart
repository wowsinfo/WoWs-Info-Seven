import 'package:http/http.dart' as http;
import 'package:logging/logging.dart';
import 'dart:convert';

/// The result of a request from BaseService.
///
/// In case of an error, the error is stored in [errorMessage].
/// In case of success, the data is stored in [data].
/// The data can still be empty without errors so make sure to check [isNotEmpty].
class ServiceResult<T> {
  T? data;
  String? errorMessage;

  bool get hasError => errorMessage != null;
  bool get isNotEmpty => data != null;

  ServiceResult({T? data, String? errorMessage}) {
    data = data;
    errorMessage = errorMessage;
  }
}

/// The base class of all services.
///
/// It provides a simple way to call the API and decode the json string.
abstract class BaseService {
  abstract final String baseUrl;

  /// Timeout in secondsa
  final int timeout = 30;
  final _logger = Logger('BaseService');

  /// Get decoded object from the url with proper error handling & timeout.
  Future<ServiceResult<Object?>> getObject(String url) async {
    try {
      final uri = Uri.parse(url);
      final response = await http.get(uri).timeout(Duration(seconds: timeout));
      if (response.statusCode == 200) {
        // dynamic shouldn't be used because it disables type checking
        final Object? json = jsonDecode(response.body);
        return ServiceResult(data: json);
      } else {
        final errorCode = response.statusCode;
        _logger.warning('getObject failed with code: $errorCode');
        // TODO: add a localizable error message here as well
        return ServiceResult(
          errorMessage: 'HTTP Error: $errorCode',
        );
      }
    } catch (e) {
      _logger.severe('getObject exception: $e');
      // TODO: we can add a properly localised error message here
      return ServiceResult(errorMessage: e.toString());
    }
  }
}
