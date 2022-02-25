import 'package:wowsinfo/models/github/github_plugins.dart';
import 'package:wowsinfo/services/api/GithubDataProvider.dart';

class PluginApi extends GithubDataProvider<Plugin> {
  @override
  String getExtraFields() => 'WoWs-Game-Data/master/data/plugin.json';
}
