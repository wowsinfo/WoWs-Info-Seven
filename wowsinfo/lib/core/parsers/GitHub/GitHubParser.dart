import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:wowsinfo/core/others/Utils.dart';

/// Like `APIParser`, however, this is simpler because the link is constant
abstract class GitHubParser {
  String link;

  GitHubParser();
  Future<Map<String, dynamic>> download() async {
    try {      
      final response = await http.get(
        this.link,
      ).timeout(Duration(seconds: 8));

      // First, check it is 200 (the server is live)
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        return json;
      }

      return null;
    } catch (e) {
      Utils.debugPrint(e);
      return null;
    }
  }

  /// Basically one line for all parsers
  dynamic parse(Map<String, dynamic> json);
}