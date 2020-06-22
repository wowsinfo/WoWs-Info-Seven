import 'package:wowsinfo/core/models/GitHub/Plugin.dart';
import 'package:wowsinfo/core/services/api/GithubDataProvider.dart';

class PluginApi extends GithubDataProvider<Plugin> {
  @override
  String getExtraFields() => 'WoWs-Game-Data/master/data/plugin.json';
}
