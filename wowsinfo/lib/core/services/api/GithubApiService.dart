import 'dart:convert';

import 'package:wowsinfo/core/models/JsonModel.dart';
import 'package:wowsinfo/core/services/api/BaseApiService.dart';
import 'package:wowsinfo/core/utils/Utils.dart';
import 'package:http/http.dart' as http;

/// Only an url is needed for data from Github
abstract class GithubApiService<T extends JsonModel> extends BaseApiService<T> {
  @override
  Future<T> requestData() async {
    try {
      final response = await http
          .get(
            getRequestLink(),
          )
          .timeout(Duration(seconds: 8));

      // Return the body only when it is 200 all good
      if (response.statusCode == 200) {
        final body = response.body;
        if (body.isNotEmpty) return parse(body);
      }

      return null;
    } catch (e) {
      Utils.debugPrint(e);
      return null;
    }
  }

  /// This is the top level link which is just my GitHub profile page
  @override
  String getBaseLink() => 'https://raw.githubusercontent.com/HenryQuan/';
}
