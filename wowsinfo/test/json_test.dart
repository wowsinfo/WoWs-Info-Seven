import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:wowsinfo/core/models/Wiki/WikiEncyclopedia.dart';

void main() {
  test('Load encyclopedia into memory', () async {
    final file = File('test/json/encyclopedia.json');
    final jsonString = await file.readAsString();
    Map<String, dynamic> jsonMap = jsonDecode(jsonString);
    final output = jsonEncode(jsonMap['data']);
    
    final encyclopedia = WikiEncyclopedia.fromJson(jsonMap['data']);
    final myOutput = jsonEncode(encyclopedia.toJson());

    expect(myOutput == output, isTrue);
  });
}
