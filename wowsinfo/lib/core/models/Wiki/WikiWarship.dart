
import 'package:wowsinfo/core/data/CachedData.dart';

import '../Cacheable.dart';

/// This is the `WikiWarship` class
class WikiWarship extends Cacheable {
  Map<String, Warship> ships;

  WikiWarship.fromJson(Map<String, dynamic> json) {
    this.ships = json.map((a, b) => MapEntry(a, Warship.fromJson(b)));
  }

  Map<String, dynamic> toJson() => this.ships.cast<String, dynamic>();
  
  @override
  void save() => cached.saveWarship(this);
}

/// This is the `Warship` class
class Warship {
  int tier;
  String name;
  int shipId;
  String shipIdStr;
  bool isSpecial;
  String nation;
  bool isPremium;
  DefaultProfile _defaultProfile;
  Image _image;
  String type;

  int get health => _defaultProfile.health;
  String get tierString => ['I', 'II', 'III', 'IV', 'V', 'VI', 'VII', 'VIII', 'IX', 'X'][tier - 1];
  String get tierName => '$tierString $name';
  String get tierType => '$tierString $typeString';
  String get nationShipType => '$nationString $typeString';
  String get shipIdAndIdStr => '$shipIdStr $shipId';
  bool get isSpecialOrPremium => isSpecial || isPremium;
  String get smallImage => _image.small;
  String get typeString {
    final cached = CachedData.shared;
    return cached.getTypeString(type);
  }
  String get nationString {
    final cached = CachedData.shared;
    return cached.getNationString(nation);
  }

  /// Check if this ship is similar to curr ship
  bool isSimilar(Warship s) {
    if (s.name.startsWith('[')) return false;
    return s.tier == tier && s.type == type;
  }

  Warship.fromJson(Map<String, dynamic> json) {
    this.tier = json['tier'];
    this.name = json['name'];
    this.shipId = json['ship_id'];
    this.isSpecial = json['is_special'];
    this.nation = json['nation'];
    this.isPremium = json['is_premium'];
    this.shipIdStr = json['ship_id_str'];
    this._defaultProfile = DefaultProfile.fromJson(json['default_profile']);
    this._image = Image.fromJson(json['images']);
    this.type = json['type'];
  }

  Map<String, dynamic> toJson() {
    return {
      'tier': this.tier,
      'name': this.name,
      'ship_id': this.shipId,
      'is_special': this.isSpecial,
      'nation': this.nation,
      'is_premium': this.isPremium,
      'ship_id_str': this.shipIdStr,
      'default_profile': this._defaultProfile,
      'images': this._image,
      'type': this.type,
    };
  }
}

/// This is the `DefaultProfile` class
class DefaultProfile {
  Armour armour;
  int get health => armour?.health;

  DefaultProfile.fromJson(Map<String, dynamic> json) {
    if (json['armour'] != null) this.armour = Armour.fromJson(json['armour']);
  }

  Map<String, dynamic> toJson() {
    return {
      'armour': this.armour,
    };
  }

}

/// This is the `Armour` class
class Armour {
  int health;

  Armour.fromJson(Map<String, dynamic> json) {
    this.health = json['health'] ?? 0;
  }

  Map<String, dynamic> toJson() {
    return {
      'health': this.health,
    };
  }
}

/// This is the `Image` class
class Image {
  String small;

  Image.fromJson(Map<String, dynamic> json) {
    this.small = json['small'];
  }

  Map<String, dynamic> toJson() {
    return {
      'small': this.small,
    };
  }
}
