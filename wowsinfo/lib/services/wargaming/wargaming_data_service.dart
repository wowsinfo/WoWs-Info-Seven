import 'package:wowsinfo/models/wowsinfo/game_server.dart';
import 'package:wowsinfo/services/service_base.dart';

/// This imports [apiKey] from key.dart.
import 'key.dart';

/// This service handles data downloading.
///
/// This service is unlike `WargamingService` where it needs to download data
/// from the API. The API splits the data into multiple pages so often multiple
/// requests are needed to get all the data in a method.
@Deprecated('This service is replaced with `GameRepository`.')
class WargamingDataService extends BaseService {
  /// The wargaming server
  WargamingDataService(GameServer server, {String language = 'en'}) {
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
}
