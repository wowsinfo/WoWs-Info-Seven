class Achievement {
  Achievement({
    required this.icon,
    required this.name,
    required this.description,
    required this.type,
    required this.id,
    required this.constants,
  });

  String icon;
  String name;
  String description;
  List<String> type;
  int id;

  /// This field can be empty. The number can be int or double.
  Map<String, dynamic> constants;

  factory Achievement.fromJson(Map<String, dynamic> json) => Achievement(
        icon: json['icon'],
        name: json['name'],
        description: json['description'],
        type: List<String>.from(json['type'].map((x) => x)),
        id: json['id'],
        constants: Map.from(json['constants'])
            .map((k, v) => MapEntry<String, dynamic>(k, v)),
      );
}
