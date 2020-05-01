import 'package:wowsinfo/core/models/GitHub/Plugin.dart';
import 'package:wowsinfo/core/parsers/GitHub/GitHubParser.dart';

class PluginParser extends GitHubParser {
  PluginParser() : super() {
    this.link = 'https://raw.githubusercontent.com/HenryQuan/WoWs-Game-Data/master/data/plugin.json';
  }

  @override
  Plugin parse(Map<String, dynamic> json) {
    if (json == null) return null;
    return Plugin.fromJson(json);
  }
}