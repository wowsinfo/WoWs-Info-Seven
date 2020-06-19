import 'dart:convert';

import 'package:wowsinfo/core/models/GitHub/PRData.dart';
import 'package:wowsinfo/core/services/api/GithubApiService.dart';

class PRDataGetter extends GithubApiService<PRData> {
  @override
  String getExtraFields() => 'WoWs-Info-Future/API/json/personal_rating.json';

  @override
  PRData parse(Object response) {
    return PRData.fromJson(jsonDecode(response));
  }
}
