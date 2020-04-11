/// This is the `WikiConsumable` class
class WikiConsumable {
  Map<String, Consumable> consumable;

  WikiConsumable.fromJson(Map<String, dynamic> json) {
    this.consumable = json.cast<String, Consumable>();
  }

  Map<String, dynamic> toJson() => this.consumable.cast<String, dynamic>();
}

/// This is the `Consumable` class
class Consumable {
  Map<String, Profile> profile;
  String name;
  int priceGold;
  String image;
  int consumableId;
  int priceCredit;
  String type;
  String description;

  Consumable.fromJson(Map<String, dynamic> json) {
    this.profile = json['profile'].cast<String, Profile>();
    this.name = json['name'];
    this.priceGold = json['price_gold'];
    this.image = json['image'];
    this.consumableId = json['consumable_id'];
    this.priceCredit = json['price_credit'];
    this.type = json['type'];
    this.description = json['description'];
  }

  Map<String, dynamic> toJson() {
    return {
      'profile': this.profile.cast<String, dynamic>(),
      'name': this.name,
      'price_gold': this.priceGold,
      'image': this.image,
      'consumable_id': this.consumableId,
      'price_credit': this.priceCredit,
      'type': this.type,
      'description': this.description,
    };
  }
}

/// This is the `Profile` class
class Profile {
  String description;
  int value;

  Profile.fromJson(Map<String, dynamic> json) {
    this.description = json['description'];
    this.value = json['value'];
  }

  Map<String, dynamic> toJson() {
    return {
      'description': this.description,
      'value': this.value,
    };
  }
}
