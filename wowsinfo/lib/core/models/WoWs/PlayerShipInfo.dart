import 'package:wowsinfo/core/data/CachedData.dart';
import 'package:wowsinfo/core/models/UI/PersonalRating.dart';
import 'package:wowsinfo/core/models/UI/WoWsDate.dart';
import 'package:wowsinfo/core/models/Wiki/WikiWarship.dart';
import 'package:wowsinfo/core/models/WoWs/RankPlayerShipInfo.dart';

import 'PvP.dart';

/// This is the `PlayerShipInfo` class, one ship or all ships, the structure is the same
class PlayerShipInfo {
  List<ShipInfo> ships = [];
  bool get isSingleShip => ships.length == 1;
  PersonalRating overallRating = PersonalRating();
  bool canSort = true;
  final _cached = CachedData.shared;

  PlayerShipInfo(Map<String, dynamic> data) {
    final List json = data.values.first;
    if (json != null) {
      json.forEach((element) {
        final curr = ShipInfo(element);
        // TODO: Ignore removed ships (can consider to support them in the future)
        if (_cached.getShip(curr.shipId) != null) {
          ships.add(curr);
          if (curr.rating.hasRating) overallRating.add(curr.rating);
        }
      });

      // Calculate overall rating
      overallRating.calculate();
    }
  }

  /// Convert rank player ship info into a normal ship info
  PlayerShipInfo.fromRank(RankPlayerShipInfo rank, String season) {
    canSort = false;
    rank.getShipsFor(season: season).forEach((element) {
      if (element.played) {
        final curr = ShipInfo.fromSeason(element);
        if (_cached.getShip(curr.shipId) != null) {
          ships.add(curr);
          if (curr.rating.hasRating) overallRating.add(curr.rating);
        }
      }
    });

    // Calculate overall rating
    overallRating.calculate();
  }
}

/// This is the `ShipInfo` class, at least `PvP` and `shipId` are needed
class ShipInfo {
  PvP pvp;
  WoWsDate lastBattleTime;
  int accountId;
  int distance;
  int updatedAt;
  int battle;
  int shipId;
  dynamic private;
  PersonalRating rating;

  Warship get ship => CachedData.shared.getShip(shipId);

  ShipInfo(Map<String, dynamic> json) {
    if (json['pvp'] != null) this.pvp = PvP(json['pvp']);
    if (json['last_battle_time'] != null) this.lastBattleTime = WoWsDate(json['last_battle_time']);
    this.accountId = json['account_id'];
    this.distance = json['distance'];
    this.updatedAt = json['updated_at'];
    this.battle = json['battles'];
    this.shipId = json['ship_id'];
    this.private = json['private'];
    this.rating = PersonalRating.fromShip(this);
  }

  /// Data is all stored in season
  ShipInfo.fromSeason(Season season) {
    pvp = season.rankSolo;
    shipId = season.shipId;
    rating = PersonalRating.fromShip(this);
    battle = season.rankSolo.battle;
  }
}
