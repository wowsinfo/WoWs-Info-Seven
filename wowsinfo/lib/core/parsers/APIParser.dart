import 'dart:convert';
import 'key.dart';

import 'package:wowsinfo/core/data/Preference.dart';
import 'package:wowsinfo/core/others/Utils.dart';
import 'package:http/http.dart' as http;

/// This is the base of all parsers, it fetches data and parse it to objects
abstract class APIParser {
  /// The link is incomplete, make sure all parsers will ask for necessary parametre and complete the string
  String link = 'https://api.worldofwarships.';
  final pref = Preference.shared;

  /// In case, you save a player in another server (you can pass it here)
  APIParser(String server) {
    this.link += server;
  }

  /// Download API String and do some basic checks
  Future<Map<String, dynamic>> download() async {
    // Append language string first
    addLanguage();

    try {      
      final response = await http.get(
        this.link,
      ).timeout(Duration(seconds: 8));

      // First, check it is 200 (the server is live)
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        // Sometimes, the server is live but it doesn't return anything
        if (validResponse(json)) return json;
        return null;
      }

      return null;
    } catch (e) {
      Utils.debugPrint(e);
      return null;
    }
  }

  /// Append language in the end
  void addLanguage() => this.link += '&language=${pref.serverLanguage}';
  void addAPIKey() => this.link += '?application_id=${API_KEY}';
  
  /// Check if this is a valid reponse
  bool validResponse(Map<String, dynamic> json) => Utils.guard(json, 'status', 'not ok') == 'ok';

  /// Parse json to object
  /// - status need to be checked first
  dynamic parse(Map<String, dynamic> json);
}
