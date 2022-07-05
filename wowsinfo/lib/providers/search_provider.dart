import 'dart:async';

import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:wowsinfo/foundation/app.dart';
import 'package:wowsinfo/models/wargaming/search_result.dart';
import 'package:wowsinfo/models/wowsinfo/game_server.dart';
import 'package:wowsinfo/repositories/user_repository.dart';
import 'package:wowsinfo/services/wargaming/wargaming_service.dart';
import 'package:wowsinfo/widgets/page/clan/clan_page.dart';

class SearchProvider with ChangeNotifier {
  final _logger = Logger('SearchProvider');
  final TextEditingController _searchController;
  SearchProvider(this._searchController) {
    _searchController.addListener(() {
      _onTextChanged();
    });
  }

  final _userRepository = UserRepository.instance;
  late final _service = WargamingService(
    GameServer.fromIndex(_userRepository.gameServer),
  );

  String _input = '';
  bool get canClear => _input.isNotEmpty;

  Timer? _timer;

  int _numOfPlayers = 0;
  int _numOfClans = 0;

  int get numOfPlayers => _numOfPlayers;
  int get numOfClans => _numOfClans;

  List<ClanResult> _clans = [];
  List<PlayerResult> _players = [];

  List<ClanResult> get clans => _clans;
  List<PlayerResult> get players => _players;

  bool _isSameInput(String input) {
    return input == _input;
  }

  /// The listener callback of the [_searchController].
  void _onTextChanged() {
    // cancel previous timer
    _timer?.cancel();
    final input = _searchController.text;

    if (_isSameInput(input)) {
      _logger.fine('input is the same as previous one');
      return;
    }

    _timer = Timer(const Duration(milliseconds: 500), () {
      search(input);
    });
  }

  void search(String query) {
    if (_isSameInput(query)) {
      _logger.fine('input is the same as previous one');
      return;
    }
    _input = query;

    final length = query.length;
    _logger.info('Searching for $query');
    if (length <= 1) {
      _logger.info('Search query is too short');
      resetAll();
      return;
    }

    //  2 - 5 characters for clans
    if (length > 1 && length <= 5) {
      _searchClan(query);
    } else {
      _resetClans();
    }

    // min 3 characters for players
    if (length > 2) {
      _searchPlayer(query);
    }
  }

  void onResultSelected(BuildContext context, SearchResult result) {
    if (result is ClanResult) {
      Navigator.of(context).push(
        App.platformPageRoute(
          builder: (context) {
            return ClanPage(clan: result);
          },
        ),
      );
    } else if (result is PlayerResult) {
      Navigator.pushNamed(context, '/player', arguments: result.accountId);
    }
  }

  void _searchClan(String query) async {
    _logger.info('Searching for clan $query');
    final result = await _service.searchClan(query);
    if (result.isNotEmpty) {
      final clanList = result.data;
      if (clanList != null) {
        _numOfClans = clanList.length;
        _clans = clanList;
        notifyListeners();
      }
    }
  }

  void _searchPlayer(String query) async {
    _logger.info('Searching for player $query');
    final result = await _service.searchPlayer(query);
    if (result.isNotEmpty) {
      final playerList = result.data;
      if (playerList != null) {
        _numOfPlayers = playerList.length;
        _players = playerList;
        notifyListeners();
      }
    }
  }

  void _resetPlayers() {
    _numOfPlayers = 0;
    _players = [];
    notifyListeners();
  }

  void _resetClans() {
    _numOfClans = 0;
    _clans = [];
    notifyListeners();
  }

  void resetAll() {
    _resetPlayers();
    _resetClans();
    _searchController.clear();
  }
}
