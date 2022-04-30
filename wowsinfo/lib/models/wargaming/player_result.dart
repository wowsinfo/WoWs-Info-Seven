/// The search result with a given nickname.
class PlayerResult {
  PlayerResult({
    this.nickname,
    this.accountId,
  });

  final String? nickname;
  final int? accountId;

  factory PlayerResult.fromJson(Map<String, dynamic> json) => PlayerResult(
        nickname: json['nickname'],
        accountId: json['account_id'],
      );
}
