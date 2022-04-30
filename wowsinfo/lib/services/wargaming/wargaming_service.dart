import 'package:logging/logging.dart';
import 'package:wowsinfo/models/wargaming/player_result.dart';
import 'package:wowsinfo/models/wargaming/server_status.dart';
import 'package:wowsinfo/services/service_base.dart';

/// This imports [apiKey] from key.dart.
import 'key.dart';

class WargamingService extends BaseService {
  @override
  String get baseUrl => 'https://api.worldofwarships.$_server/wows';

  final String _server;
  late final String _language;
  final String _applicationID = '?application_id=$apiKey';

  WargamingService(this._server, {String language = 'en'}) {
    _language = language;
  }

  /// Get the current online players count.
  Future<ServiceResult<ServerStatus?>> getServerStatus() async {
    final url =
        'https://api.worldoftanks.$_server/wgn/servers/info/$_applicationID&game=wows';

    final result = await getObject(url);
    return decodeObject(result, ServerStatus.fromJson);
  }

  /// Get a list of players with the given [nickname].
  Future<ServiceResult<List<PlayerResult>>> searchPlayer(
    String nickname,
  ) async {
    final url = baseUrl + '/account/list/$_applicationID&search=$nickname';
    final result = await getObject(url);
    return decodeList(result, PlayerResult.fromJson);
  }
}
