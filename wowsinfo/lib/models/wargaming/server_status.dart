import 'package:wowsinfo/models/wargaming/wargaming_base.dart';

class ServerStatus extends WargamingAPI<_StatusData> {
  int? get playersOnline {
    final wows = data?.wows;
    // make sure the list is not empty here
    if (wows != null && wows.isNotEmpty) {
      assert(wows.length == 1, "There should be only one element in it");
      return wows[0].playersOnline;
    }
    return null;
  }

  ServerStatus.fromJson(Map<String, dynamic> json) : super.fromJson(json);
}

class _StatusData {
  List<_OnlineData>? wows;

  _StatusData.fromJson(Map<String, dynamic> json) {
    wows = json['wows'];
  }
}

class _OnlineData {
  int? playersOnline;
  String? server;

  _OnlineData.fromJson(Map<String, dynamic> json) {
    playersOnline = json["players_online"];
    server = json["server"];
  }
}
