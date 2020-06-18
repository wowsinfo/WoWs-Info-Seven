import 'package:wowsinfo/core/services/api/GithubApiService.dart';

class PRDataGetter extends GithubApiService {
  @override
  String getRequestLink() => super.getRequestLink() + 'WoWs-Info-Future/API/json/personal_rating.json';
}
