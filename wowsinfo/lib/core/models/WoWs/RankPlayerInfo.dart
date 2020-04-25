import 'package:wowsinfo/core/models/WoWs/RankPlayerShipInfo.dart';

/// This is the `RankPlayerInfo` class
class RankPlayerInfo {
  Map<String, Season> season;
  /// Sort by season name and also ignore seasons that the player never played a single game
  List<MapEntry<String, Season>> get sortedSeasons => season.entries
    .where((e) => e.value.played)
    .toList(growable: false)
    // Parse it as number and sort it by it
    ..sort((b, a) => int.parse(a.key) - int.parse(b.key));
  int accountId;

  RankPlayerInfo(Map<String, dynamic> data) {
    final json = data.values.first;
    if (json != null) {
      this.season = (json['seasons'] as Map).map((a, b) => MapEntry(a, Season(b)));
      this.accountId = json['account_id'];
    }
  }
}

/// This is the `Season` class
class Season {
  RankInfo rankInfo;
  RankPvP rankSolo;
  // Thses two should always be null
  dynamic rankDiv2;
  dynamic rankDiv3;

  bool get played => rankSolo != null;

  Season(Map<String, dynamic> json) {
    if (json['rank_info'] != null) this.rankInfo = RankInfo(json['rank_info']);
    if (json['rank_solo'] != null) this.rankSolo = RankPvP(json['rank_solo']);
    this.rankDiv2 = json['rank_div2'];
    this.rankDiv3 = json['rank_div3'];
  }
}

/// This is the `RankInfo` class
class RankInfo {
  int maxRank;
  int startRank;
  int star;
  int rank;
  int stage;

  RankInfo(Map<String, dynamic> json) {
    this.maxRank = json['max_rank'];
    this.startRank = json['start_rank'];
    this.star = json['stars'];
    this.rank = json['rank'];
    this.stage = json['stage'];
  }
}
