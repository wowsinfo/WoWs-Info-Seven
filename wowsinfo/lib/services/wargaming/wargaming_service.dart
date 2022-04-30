import 'package:flutter/foundation.dart';
import 'package:wowsinfo/models/wargaming/player_result.dart';
import 'package:wowsinfo/models/wargaming/server_status.dart';
import 'package:wowsinfo/models/wowsinfo/game_server.dart';
import 'package:wowsinfo/services/service_base.dart';

/// This imports [apiKey] from key.dart.
import 'key.dart';

/// This service takes care of usual API requests.
///
/// Unlike `WargamingDataService` where it handles more complicated requests,
/// this service
@immutable
class WargamingService extends BaseService {
  /// The wargaming server
  WargamingService(GameServer server, {String language = 'en'}) {
    _server = server.domain;
    _language = language;
  }

  @override
  String get baseUrl => 'https://api.worldofwarships.$_server/wows';

  /// The wargaming endpoint used by a few methods.
  String get _wgnUrl => 'https://api.worldoftanks.$_server/wgn';

  late final String _server;
  late final String _language;
  final String _applicationId = '?application_id=$apiKey';

  /// Get the current online players count.
  Future<ServiceResult<ServerStatus?>> getServerStatus() async {
    // this is under wowt
    final result = await getObject(
      _wgnUrl + '/servers/info/$_applicationId&game=wows',
    );
    return decodeObject(result, ServerStatus.fromJson);
  }

  /// Get a list of players with the given [nickname].
  Future<ServiceResult<List<PlayerResult>>> searchPlayer(
    String nickname,
  ) async {
    // TODO: https://api.worldoftanks.asia/wgn/account/list/ is a better endpoint
    final url = baseUrl + '/account/list/$_applicationId&search=$nickname';
    final result = await getObject(url);
    return decodeList(result, PlayerResult.fromJson);
  }
}
