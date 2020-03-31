import '../Meta.dart';
import 'PvP.dart';

/// This is the `PlayerShipInfo` class, one ship or all ships, the structure is the same
class PlayerShipInfo {
  Meta meta;
  Data data;
  /// This determines whether this is a single ship data
  bool get isSingleShip => data.isSingleShip();

  PlayerShipInfo(json) {
    this.meta = Meta(json["meta"]);
    this.data = Data(json["data"]);
  }
}

/// This is the `Data` class
class Data {
  List<ShipInfo> ships;

  Data(json) {
    this.ships = json["2011774448"];
  }

  bool isSingleShip() => ships.length == 1;
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
  Null private;

  ShipInfo(json) {
    this.pvp = PvP(json["pvp"]);
    this.lastBattleTime = json["last_battle_time"];
    this.accountId = json["account_id"];
    this.distance = json["distance"];
    this.updatedAt = json["updated_at"];
    this.battle = json["battles"];
    this.shipId = json["ship_id"];
    this.private = json["private"];
  }
}
