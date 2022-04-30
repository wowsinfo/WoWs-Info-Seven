import 'package:logging/logging.dart';
import 'package:wowsinfo/models/wargaming/server_status.dart';
import 'package:wowsinfo/services/service_base.dart';

/// This imports [apiKey] from key.dart.
import 'key.dart';

class WargamingService extends BaseService {
  @override
  String get baseUrl => 'https://api.worldofwarships.$_server/wows/';

  final String _server;
  late final String _language;
  final String _applicationID = '?application_id=$apiKey';
  final _logger = Logger('WargamingService');

  WargamingService(this._server, {String language = 'en'}) {
    _language = language;
  }

  Future<ServiceResult<ServerStatus?>> getServerStatus() async {
    final url =
        'https://api.worldoftanks.$_server/wgn/servers/info/$_applicationID&game=wows';

    final result = await getObject(url);
    return _decode(result, ServerStatus.fromJson);
  }

  ServiceResult<T> _decode<T>(
    ServiceResult<Object?> json,
    ModelCreator creator,
  ) {
    if (json.hasError) return ServiceResult.copyWith(json);

    if (json.isNotEmpty) {
      final jsonData = json.data;
      if (jsonData is Map<String, dynamic>) {
        final data = jsonData['data'];
        if (data is Map<String, dynamic>) {
          _logger.info('Successfully decoded $T');
          return ServiceResult(data: creator(data));
        } else {
          _logger.severe('data is not a Map<String, dynamic>');
        }
      }
    } else {
      _logger.severe('json.data is null, API failure');
    }

    _logger.severe('failed to decode $T', json);
    return ServiceResult(errorMessage: 'Decoding failure in $T');
  }
}
