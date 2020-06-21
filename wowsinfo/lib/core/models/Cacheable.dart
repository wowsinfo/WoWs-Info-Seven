import 'dart:convert';

import 'package:wowsinfo/core/models/JsonModel.dart';

/// For models that are going to be cached locally
/// - The output can be a json map or a json string
abstract class Cacheable extends JsonModel {
  Cacheable(Map<String, dynamic> json) : super(json);

  /// Check if the data is valid and whether it is corrupted
  bool isValid();

  Map<String, dynamic> toJson();

  String jsonString() => jsonEncode(this.toJson());
}
