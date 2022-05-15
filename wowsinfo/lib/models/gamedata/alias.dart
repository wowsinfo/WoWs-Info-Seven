import 'package:flutter/foundation.dart';

@immutable
class Alias {
  const Alias({
    required this.alias,
  });

  final String alias;

  factory Alias.fromJson(Map<String, dynamic> json) => Alias(
        alias: json['alias'],
      );
}
