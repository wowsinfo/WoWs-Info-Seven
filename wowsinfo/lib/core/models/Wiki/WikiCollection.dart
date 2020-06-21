import 'package:flutter/material.dart';
import 'package:wowsinfo/core/models/Cacheable.dart';
import 'package:wowsinfo/core/models/Mergeable.dart';
import 'package:wowsinfo/core/models/Wiki/WikiItem.dart';

/// This is the `WikiCollection` class
class WikiCollection extends Cacheable implements Mergeable<WikiCollection> {
  Map<String, Collection> collection;

  WikiCollection.fromJson(Map<String, dynamic> json) : super(json) {
    this.collection = json.map((a, b) => MapEntry(a, Collection.fromJson(b)));
  }

  Map<String, dynamic> toJson() => this.collection.cast<String, dynamic>();

  @override
  bool isValid() => collection.isNotEmpty;

  @override
  merge(WikiCollection object) {
    if (object != null) collection.addAll(object.collection);
  }

  @override
  mergeAll(Iterable<WikiCollection> object) {
    object.forEach((e) => this.merge(e));
  }
}

/// This is the `Collection` class
class Collection extends WikiItem {
  int collectionId;

  Collection.fromJson(Map<String, dynamic> json) {
    this.collectionId = json['collection_id'];
    this.image = json['image'];
    this.name = json['name'];
    this.description = json['description'];
  }

  Map<String, dynamic> toJson() {
    return {
      'collection_id': this.collectionId,
      'image': this.image,
      'name': this.name,
      'description': this.description,
    };
  }

  @override
  Future displayDialog(BuildContext context) {
    // This shouldn't be called
    throw UnimplementedError();
  }
}
