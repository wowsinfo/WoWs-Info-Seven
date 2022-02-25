import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:wowsinfo/models/Cacheable.dart';
import 'package:wowsinfo/models/Mergeable.dart';
import 'package:wowsinfo/models/Wiki/WikiItem.dart';

/// This is the `WikiCollection` class
class WikiCollection implements Cacheable, Mergeable<WikiCollection> {
  Map<String, Collection> collection;

  WikiCollection.fromJson(Map<String, dynamic> json) {
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

  @override
  output() => jsonEncode(toJson());
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
