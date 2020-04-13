import '../APIModel.dart';

/// This is the `WikiCollection` class
class WikiCollection extends APIModel {
  Map<String, Collection> collection;

  WikiCollection.fromJson(Map<String, dynamic> json) {
    this.collection = json.map((a, b) => MapEntry(a, Collection.fromJson(b)));
  }

  Map<String, dynamic> toJson() => this.collection.cast<String, dynamic>();
}

/// This is the `Collection` class
class Collection {
  int collectionId;
  String image;
  String name;
  String description;

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
}
