import 'package:flutter/foundation.dart';
import 'package:wowsinfo/models/wargaming/clan_result.dart';
import 'package:wowsinfo/models/wargaming/player_information.dart';
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
    final result = await getObject(
      _wgnUrl + '/account/list/$_applicationId&game=wows&search=$nickname',
    );
    return decodeList(result, PlayerResult.fromJson);
  }

  /// Get a list of clans with the given [tag].
  Future<ServiceResult<List<ClanResult>>> searchClan(
    String tag,
  ) async {
    final result = await getObject(
      baseUrl + '/clans/list/$_applicationId&search=$tag',
    );
    return decodeList(result, ClanResult.fromJson);
  }

  /// Get a player's information by [accountId].
  Future<ServiceResult<PlayerInformation>> getPlayerInformation(
    String accountId,
  ) async {
    // extra fields are provideded to get all the statistics
    final result = await getObject(
      baseUrl +
          '/account/info/$_applicationId&account_id=$accountId'
              '&extra=statistics.pve%2Cstatistics.pvp_div2'
              '%2Cstatistics.pvp_div3%2Cstatistics.rank_solo',
    );
    return decodeObject(result, PlayerInformation.fromJson);
  }
}
