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

    final result = await super.getObject<ServerStatus>(
      url,
      (json) => ServerStatus.fromJson(json),
    );

    return result;
  }

  @override
  T? decoder<T>(Object? json, ModelCreator<T> creator) {
    if (json is Map<String, dynamic>) {
      final data = json['data'];
      // we only need the data and nothing else
      if (data is Map<String, dynamic>) {
        return creator(data);
      }
    }

    assert(false, 'Decoding error, json or data is invalid');
    return null;
  }
}
