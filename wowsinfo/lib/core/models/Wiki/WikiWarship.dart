/// This is the `WikiWarship` class
class WikiWarship {
  Map<String, Warship> data;

  WikiWarship.fromJson(Map<String, dynamic> json) {
    this.data = json;
  }

  Map<String, dynamic> toJson() => this.data;
}

/// This is the `Warship` class
class Warship {
  int tier;
  String name;
  int shipId;
  bool isSpecial;
  String nation;
  bool isPremium;
  String shipIdStr;
  DefaultProfile _defaultProfile;
  int get health => _defaultProfile.health;
  Image _image;
  String get smallImage => _image.small;
  String type;

  Warship.fromJson(Map<String, dynamic> json) {
    this.tier = json['tier'];
    this.name = json['name'];
    this.shipId = json['ship_id'];
    this.isSpecial = json['is_special'];
    this.nation = json['nation'];
    this.isPremium = json['is_premium'];
    this.shipIdStr = json['ship_id_str'];
    this._defaultProfile = DefaultProfile.fromJson(json['default_profile']);
    this._image = Image.fromJson(json['_images']);
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
    this.armour = Armour.fromJson(json['armour']);
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
