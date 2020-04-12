import 'package:wowsinfo/core/models/WoWs/PvP.dart';

/// This is the `RankPlayerInfo` class
class RankPlayerInfo {
  Map<String, Season> season;
  int accountId;

  RankPlayerInfo(Map<String, dynamic> data) {
    final json = data.values.first;
    this.season = (json['seasons'] as Map).map((a, b) => MapEntry(a, Season(b)));
    this.accountId = json['account_id'];
  }
}

/// This is the `Season` class
class Season {
  RankInfo rankInfo;
  PvP rankSolo;
  // Thses two should always be null
  dynamic rankDiv2;
  dynamic rankDiv3;

  Season(Map<String, dynamic> json) {
    this.rankInfo = RankInfo(json['rank_info']);
    this.rankSolo = PvP(json['rank_solo']);
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
