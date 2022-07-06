import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart';
import 'package:wowsinfo/extensions/datetime.dart';
import 'package:wowsinfo/models/wargaming/clan_information.dart';
import 'package:wowsinfo/models/wargaming/search_result.dart';
import 'package:wowsinfo/models/wowsinfo/game_server.dart';
import 'package:wowsinfo/repositories/user_repository.dart';
import 'package:wowsinfo/services/wargaming/wargaming_service.dart';

class ClanProvider with ChangeNotifier {
  final _logger = Logger('ClanProvider');
  final ClanResult _clan;
  ClanProvider(this._clan) {
    _logger.info('Started loading clan info');
    final clanId = _clan.clanId;
    if (clanId != null) {
      _service.getClanInformation(clanId.toString()).then((clan) {
        final clanData = clan.data;
        if (clanData != null) _info = clanData;

        _loading = false;
        notifyListeners();
      });
    } else {
      _loading = false;
      notifyListeners();
    }
  }

  late final _service = WargamingService(
    GameServer.fromIndex(UserRepository.instance.gameServer),
  );

  ClanInformation? _info;
  bool _loading = true;
  bool get isLoading => _loading;

  String get tag => _info?.tag ?? '-';
  String get tagDescription => _info?.name ?? '-';
  String get createdDate {
    final created = _info?.createdAt;
    if (created == null) return '-';
    return created.dateTimeString;
  }

  String get creatorName => _info?.creatorName ?? '-';
  String get leaderName => _info?.leaderName ?? '-';
  String? get description => _info?.description;
  int get memberCount => _info?.membersCount ?? 0;
  Iterable<ClanMember>? get members => _info?.members?.values;
}
