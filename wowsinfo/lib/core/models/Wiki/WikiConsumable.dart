import 'package:flutter/material.dart';
import 'package:wowsinfo/core/models/Cacheable.dart';
import 'package:wowsinfo/core/models/Wiki/WikiItem.dart';

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
class Consumable extends WikiItem {
  Map<String, Profile> profile;
  int priceGold;
  int consumableId;
  int priceCredit;
  String type;

  String get priceString => isGold ? priceGold.toString() : priceCredit.toString();
  bool get isGold => priceGold > 0;
  String get profileString => profile.values.map((e) => e.description).join('\n');

  Consumable.fromJson(Map<String, dynamic> json) {
    this.profile = (json['profile'] as Map).map((a, b) => MapEntry(a, Profile.fromJson(b)));
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

  int compareTo(Consumable other) {
    if (priceCredit == other.priceCredit) return consumableId.compareTo(other.consumableId);
    return priceCredit.compareTo(other.priceCredit);
  }

  @override
  Future displayDialog(BuildContext context) {
    final dark = Theme.of(context).brightness == Brightness.dark;

    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: ListTile(
          contentPadding: const EdgeInsets.all(2),
          isThreeLine: true,
          title: Text(name),
          subtitle: RichText(
            text: TextSpan(
              style: TextStyle(color: dark ? Colors.white : Colors.black),
              children: [
                TextSpan(
                  text: priceString + '\n',
                  style: TextStyle(color: isGold ? Colors.orange : Colors.grey)
                ),
                TextSpan(
                  text: description + '\n\n',
                  style: TextStyle(fontSize: 14)
                ),
                TextSpan(
                  text: profileString,
                  style: TextStyle(fontSize: 12)
                ),
              ]
            ),
          ),
          leading: Image.network(image),
        ),
      ),
    );
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
