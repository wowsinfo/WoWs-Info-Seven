import 'package:flutter/foundation.dart';
import 'package:wowsinfo/models/wargaming/search_result.dart';
import 'package:wowsinfo/models/wowsinfo/game_server.dart';
import 'package:wowsinfo/services/wargaming/wargaming_service.dart';

class SearchProvider extends ChangeNotifier {
  int _numOfPlayers = 0;
  int _numOfClans = 0;

  List<ClanResult> _clans = [];
  List<PlayerResult> _players = [];

  int get numOfPlayers => _numOfPlayers;
  int get numOfClans => _numOfClans;

  // TODO: read from settings and this value should be provided.
  final service = WargamingService(GameServer(GameServer.defaultServer));

  void search(String query) {
    final length = query.length;
    if (length <= 1) {
      reset();
      return;
    }

    // min 2 characters for clans
    if (length > 1) {
      _searchClan(query);
    }

    // min 3 characters for players
    if (length > 2) {
      _searchPlayer(query);
    }
  }

  void _searchClan(String query) async {
    final result = await service.searchClan(query);
    if (result.isNotEmpty) {
      final clanList = result.data;
      if (clanList != null) {
        _numOfClans = clanList.length;
        _clans = clanList;
      }
    }
  }

  void _searchPlayer(String query) async {
    final result = await service.searchPlayer(query);
    if (result.isNotEmpty) {
      final playerList = result.data;
      if (playerList != null) {
        _numOfPlayers = playerList.length;
        _players = playerList;
      }
    }
  }

  void reset() {
    _numOfPlayers = 0;
    _numOfClans = 0;
    notifyListeners();
  }
}
