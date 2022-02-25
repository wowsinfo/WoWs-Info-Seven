import 'package:wowsinfo/models/github/ship_alias.dart';
import 'package:wowsinfo/services/api/GithubDataProvider.dart';

class ShipAliasGetter extends GithubDataProvider<ShipAlias> {
  @override
  String getExtraFields() => 'WoWs-Info-Future/API/json/alias.json';
}
