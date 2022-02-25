import 'package:wowsinfo/models/github/personal_rating_data.dart';
import 'package:wowsinfo/services/api/GithubDataProvider.dart';

class PRDataGetter extends GithubDataProvider<PRData> {
  @override
  String getExtraFields() => 'WoWs-Info-Future/API/json/personal_rating.json';
}
