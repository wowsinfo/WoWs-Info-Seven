import 'package:wowsinfo/core/models/GitHub/ShipAlias.dart';
import 'package:wowsinfo/core/services/api/GithubDataProvider.dart';

class ShipAliasGetter extends GithubDataProvider<ShipAlias> {
  @override
  String getExtraFields() => 'WoWs-Info-Future/API/json/alias.json';
}
