import 'dart:convert';

import 'package:wowsinfo/core/models/GitHub/Plugin.dart';
import 'package:wowsinfo/core/services/api/GithubApiService.dart';

class PluginApi extends GithubApiService<Plugin> {
  @override
  String getExtraFields() => 'WoWs-Game-Data/master/data/plugin.json';

  @override
  Plugin parse(Object response) {
    return Plugin.fromJson(jsonDecode(response));
  }
}
