import 'package:wowsinfo/core/services/api/GithubApiService.dart';

class PluginApi extends GithubApiService {
  @override
  String getExtraFields() => 'WoWs-Game-Data/master/data/plugin.json';
}
