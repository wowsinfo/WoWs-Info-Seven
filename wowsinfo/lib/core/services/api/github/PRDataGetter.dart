import 'package:wowsinfo/core/services/api/GithubApiService.dart';

class PRDataGetter extends GithubApiService {
  @override
  String getExtraFields() => 'WoWs-Info-Future/API/json/personal_rating.json';
}
