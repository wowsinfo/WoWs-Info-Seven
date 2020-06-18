import 'package:flutter/material.dart';

/// This is the parent of all wiki items, basic properties are shared
abstract class WikiItem {
  String name;
  String image;
  String description;

  /// How to display a dialog for this item?
  Future displayDialog(BuildContext context);
}
