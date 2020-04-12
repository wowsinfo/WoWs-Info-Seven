import 'PvP.dart';

/// This is the `PlayerShipInfo` class, one ship or all ships, the structure is the same
class PlayerShipInfo {
  List<ShipInfo> ships = [];
  bool get isSingleShip => ships.length == 1;

  PlayerShipInfo(Map<String, dynamic> data) {
    final List json = data.values.first;
    json.forEach((item) => ships.add(ShipInfo(item)));
  }
}

/// This is the `ShipInfo` class
class ShipInfo {
  PvP pvp;
  int lastBattleTime;
  int accountId;
  int distance;
  int updatedAt;
  int battle;
  int shipId;
  dynamic private;

  ShipInfo(Map<String, dynamic> json) {
    this.pvp = PvP(json['pvp']);
    this.lastBattleTime = json['last_battle_time'];
    this.accountId = json['account_id'];
    this.distance = json['distance'];
    this.updatedAt = json['updated_at'];
    this.battle = json['battles'];
    this.shipId = json['ship_id'];
    this.private = json['private'];
  }
}
