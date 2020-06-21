import 'package:wowsinfo/core/models/GitHub/PRData.dart';
import 'package:wowsinfo/core/services/api/GithubDataProvider.dart';

class PRDataGetter extends GithubDataProvider<PRData> {
  @override
  String getExtraFields() => 'WoWs-Info-Future/API/json/personal_rating.json';
}
