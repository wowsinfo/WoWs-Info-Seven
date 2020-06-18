import 'package:wowsinfo/core/services/api/GithubApiService.dart';

class ShipAliasGetter extends GithubApiService {
  @override
  String getRequestLink() => super.getRequestLink() + 'WoWs-Info-Future/API/json/alias.json';
}
