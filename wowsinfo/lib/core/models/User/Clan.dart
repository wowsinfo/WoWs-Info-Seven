class Clan {
  String tag;
  int clanId;
  int server;

  Clan(this.tag, this.clanId, this.server);
  Clan.fromJson(Map<String, dynamic> json) {
    this.tag = json['tag'];
    this.clanId = json['clan_id'];
    this.server = json['server'];
  }

  Map<String, dynamic> toJson() {
    return {
      'tag': tag,
      'clan_id': clanId,
      'server': server,
    };
  }
}