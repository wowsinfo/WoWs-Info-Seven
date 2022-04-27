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

  WargamingService(this._server, {String language = 'en'}) {
    _language = language;
  }

  Future<ServiceResult<ServerStatus?>> getServerStatus() async {
    final url =
        'https://api.worldoftanks.$_server/wgn/servers/info/$_applicationID&game=wows';

    final result = await getObject(url);
    if (result.hasError) return ServiceResult.copyWith(result);

    final data = result.data as Map<String, dynamic>?;
    if (data == null) return ServiceResult(errorMessage: 'No data');
    return ServiceResult(data: ServerStatus.fromJson(data));
  }
}
