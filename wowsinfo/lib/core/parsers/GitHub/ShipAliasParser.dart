import 'package:wowsinfo/core/models/GitHub/ShipAlias.dart';

import 'GitHubParser.dart';

class ShipAliasParser extends GitHubParser {
  ShipAliasParser() : super() {
    this.link = 'https://raw.githubusercontent.com/HenryQuan/WoWs-Info-Future/API/json/alias.json';
  }

  @override
  ShipAlias parse(Map<String, dynamic> json) {
    if (json == null) return null;
    return ShipAlias.fromJson(json);
  }
}
