/// player nickname, account id and server code
class Player {
  String nickname;
  int accountId;
  int server;

  Player.fromJson(json) {
    this.nickname = json["nickname"];
    this.accountId = json["account_id"];
  }
}