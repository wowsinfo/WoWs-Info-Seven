import '../Cacheable.dart';

/// This is the `WikiConsumable` class
class WikiConsumable extends Cacheable {
  Map<String, Consumable> consumable;

  WikiConsumable.fromJson(Map<String, dynamic> json) {
    this.consumable = json.map((a, b) => MapEntry(a, Consumable.fromJson(b)));
  }

  Map<String, dynamic> toJson() => this.consumable.cast<String, dynamic>();
  
  @override
  void save() => cached.saveConsumable(this);
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
  int slot = -1;

  String get priceString => isGold ? priceGold.toString() : priceCredit.toString();
  bool get isGold => priceGold > 0;
  String get profileString => profile.values.map((e) => e.description).join('\n');
  /// By default, -1 but it should start from 0
  bool get hasSlot => slot > -1;

  Consumable.fromJson(Map<String, dynamic> json) {
    this.profile = (json['profile'] as Map).map((a, b) => MapEntry(a, Profile.fromJson(b)));
    this.name = json['name'];
    this.priceGold = json['price_gold'];
    this.image = json['image'];
    this.consumableId = json['consumable_id'];
    this.priceCredit = json['price_credit'];
    this.type = json['type'];
    this.description = json['description'];

    // Get the slot for consumables
    if (type == 'Modernization') {
      int slot = 0;
      double price = this.priceCredit.toDouble();
      while (price > 125000) {
        slot += 1;
        price /= 2;
      }
      this.slot = slot;
    }
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
  double value;

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
