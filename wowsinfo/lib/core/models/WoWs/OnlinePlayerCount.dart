
class OnlinePlayerCount {
  int playersOnline;

  OnlinePlayerCount(json) {
    this.playersOnline = json['wows'][0]['players_online'];
  }
}
