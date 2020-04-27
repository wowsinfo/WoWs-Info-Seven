import 'dart:convert';
import 'package:wowsinfo/core/models/UI/GameServer.dart';
import 'package:wowsinfo/core/models/Meta.dart';

import 'key.dart';

import 'package:wowsinfo/core/data/Preference.dart';
import 'package:wowsinfo/core/others/Utils.dart';
import 'package:http/http.dart' as http;

/// This is the base of all API parsers, it fetches data and parse it to objects
abstract class APIParser {
  final pref = Preference.shared;
  /// Append language in the end
  void _addLanguage() => this.link += '&language=${pref.serverLanguage}';
  // void _addLanguage() => this.link += '&language=en';

  /// The link is incomplete, make sure all parsers will ask for necessary parametre and complete the string
  String link = 'https://api.worldofwarships.';
  int _pageNumber = 0;
  bool _hasMorePage = true;

  /// In case, you save a player in another server (you can pass it here)
  APIParser(GameServer server) {
    this.link += server.domain;
  }

  /// Download API String, `download all pages` and do some basic checks
  Future<List<Map<String, dynamic>>> download() async {
    // Utils.debugPrint(this.link);
    // Append language string first
    _addLanguage();
    List<Map<String, dynamic>> data = [];

    while (_hasMorePage) {
      // Start from page 1 and keep going
      try {      
        final response = await http.get(
          _addPageNumber(this.link),
        ).timeout(Duration(seconds: 8));

        // First, check it is 200 (the server is live)
        if (response.statusCode == 200) {
          final json = jsonDecode(response.body);
          // Sometimes, the server is live but it doesn't return anything
          if (_validResponse(json)) {
            data.add(json);
            // meta is not already there
            if (json['meta'] != null) {
              final meta = Meta(json['meta']);
              if (!meta.hasMorePage) _hasMorePage = false;
            } else _hasMorePage = false;
          } else _hasMorePage = false;
        } else _hasMorePage = false;
      } catch (e, s) {
        Utils.debugPrint(s);
        Utils.debugPrint(e);
        _hasMorePage = false;
      }
    }

    return data;
  }

  /// Append api key in the end
  void addAPIKey() => this.link += '?application_id=$API_KEY';
  /// Append api key in the end, `it keeps adding one to it`
  String _addPageNumber(String link) => this.link + '&page_no=${++_pageNumber}';
  
  /// Check if this is a valid reponse
  bool _validResponse(Map<String, dynamic> json) => Utils.guard(json, 'status', 'not ok') == 'ok';

  /// Parse json to object
  /// - status need to be checked first
  dynamic parse(List<Map<String, dynamic>> json);
}
