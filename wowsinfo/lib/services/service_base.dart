import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:logging/logging.dart';
import 'dart:convert';

/// Create a model using T.fromJson method from models
typedef ModelCreator<T> = T? Function(Map<String, dynamic>);

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

  ServiceResult({this.data, this.errorMessage});

  /// Returns a new instance of [ServiceResult] with the same data and error.
  ///
  /// This is often used to cast to a different type.
  static ServiceResult<T> copyWith<T>(ServiceResult other) {
    return ServiceResult(data: other.data, errorMessage: other.errorMessage);
  }

  @override
  String toString() {
    return 'ServiceResult{data: $data, errorMessage: $errorMessage}';
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
  @protected
  Future<ServiceResult<Object?>> getObject(String url) async {
    try {
      final uri = Uri.parse(url);
      final response = await http.get(uri).timeout(Duration(seconds: timeout));
      if (response.statusCode == 200) {
        // dynamic shouldn't be used because it disables type checking
        final Object? json = jsonDecode(response.body);
        if (json != null) {
          _logger.info('Successfully fetched data from $url');
          return ServiceResult(data: json);
        } else {
          _logger.severe('jsonDecode returned null');
          // TODO: localise error message here
          return ServiceResult(errorMessage: 'JSON decoding error');
        }
      } else {
        final errorCode = response.statusCode;
        _logger.warning('getObject failed with code: $errorCode');
        // TODO: add a localizable error message here as well
        return ServiceResult(errorMessage: 'HTTP Error: $errorCode');
      }
    } catch (e, stackTrace) {
      _logger.severe('getObject exception', e, stackTrace);
      // TODO: we can add a properly localised error message here
      return ServiceResult(errorMessage: e.toString());
    }
  }
}
