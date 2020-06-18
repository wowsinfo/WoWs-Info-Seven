import 'package:flutter/material.dart';
import 'package:wowsinfo/core/models/Cacheable.dart';
import 'package:wowsinfo/core/models/Wiki/WikiItem.dart';

/// This is the `WikiCollectionItem` class
class WikiCollectionItem extends Cacheable {
  Map<String, CollectionItem> item;

  WikiCollectionItem.fromJson(Map<String, dynamic> json) {
    this.item = json.map((a, b) => MapEntry(a, CollectionItem.fromJson(b)));
  }

  Map<String, dynamic> toJson() => this.item.cast<String, dynamic>();
  
  @override
  void save() => cached.saveCollectionItem(this);
}

/// This is the `CollectionItem` class
class CollectionItem extends WikiItem {
  int collectionId;
  int cardId;

  CollectionItem.fromJson(Map<String, dynamic> json) {
    if (json['images'] != null) this.image = CollectionItemImage.fromJson(json['images']).small;
    this.collectionId = json['collection_id'];
    this.description = json['description'];
    this.name = json['name'];
    this.cardId = json['card_id'];
  }

  Map<String, dynamic> toJson() {
    return {
      'images': this.image,
      'collection_id': this.collectionId,
      'description': this.description,
      'name': this.name,
      'card_id': this.cardId,
    };
  }

  @override
  Future displayDialog(BuildContext context) {
    // TODO: implement displayDialog
    throw UnimplementedError();
  }
}

/// This is the `CollectionItemImage` class
class CollectionItemImage {
  String small;

  CollectionItemImage.fromJson(json) {
    if (json is String) this.small = json;
    else this.small = json['small'];
  }

  Map<String, dynamic> toJson() {
    return {
      'small': this.small,
    };
  }
}