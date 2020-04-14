import 'package:wowsinfo/core/models/GitHub/PRData.dart';

import 'GitHubParser.dart';

class PRDataParser extends GitHubParser {
  PRDataParser() : super() {
    this.link = 'https://raw.githubusercontent.com/HenryQuan/WoWs-Info-Future/API/json/personal_rating.json';
  }

  @override
  PRData parse(Map<String, dynamic> json) {
    if (json == null) return null;
    return PRData.fromJson(json['data']);
  }
}
