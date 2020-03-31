import '../Meta.dart';

/// This is the `RankPlayerInfo` class
class RankPlayerInfo {
  Meta meta;
  Data data;

  RankPlayerInfo(json) {
    this.meta = Meta(json["meta"]);
    this.data = json["data"];
  }
}

/// This is the `Data` class
class Data {
  K2011774448 k2011774448;

  Data(json) {
    this.k2011774448 = json["2011774448"];
  }
}

/// This is the `K2011774448` class
class K2011774448 {
  Map<String, Season> season;

  K2011774448(json) {
    this.season = json["seasons"];
  }
}
