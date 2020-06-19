import 'package:wowsinfo/core/services/api/GithubApiService.dart';

class ShipAliasGetter extends GithubApiService {
  @override
  String getExtraFields() => 'WoWs-Info-Future/API/json/alias.json';
}
