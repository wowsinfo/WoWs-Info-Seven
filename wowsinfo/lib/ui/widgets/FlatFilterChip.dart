import 'package:flutter/material.dart';

/// FlatFilterChip class
class FlatFilterChip extends StatelessWidget {
  final Widget label;
  final bool selected;
  final void Function(bool) onSelected;
  
  const FlatFilterChip({
    Key key, 
    @required this.label, 
    this.selected, 
    @required this.onSelected
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FilterChip(
      pressElevation: 0,
      backgroundColor: Colors.transparent,
      // selectedColor: Colors.transparent,
      label: label,
      selected: selected ?? false,
      onSelected: onSelected
    );
  }
}
