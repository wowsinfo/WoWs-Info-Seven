import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:wowsinfo/models/github/github_plugins.dart';

void main() {
  test('Load plugin into memory', () async {
    final file = File('test/json/plugin.json');
    final jsonString = await file.readAsString();
    Map<String, dynamic> jsonMap = jsonDecode(jsonString);
    final output = jsonEncode(jsonMap);

    final a = Plugin.fromJson(jsonMap);
    expect(
        a.consumable['PCY020_RLSSearchPremium']?.data['USSR_8_BB']?.distShip ==
            500,
        isTrue);
    final myOutput = jsonEncode(a.toJson());

    // I ignored many data
    expect(myOutput == output, isFalse);
  });
}
