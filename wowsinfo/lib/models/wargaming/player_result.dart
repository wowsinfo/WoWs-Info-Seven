import 'package:flutter/foundation.dart';
import 'package:wowsinfo/models/encodable.dart';

/// The search result with a given nickname.
@immutable
class PlayerResult implements Encodable {
  const PlayerResult({
    this.nickname,
    this.accountId,
  });

  final String? nickname;
  final int? accountId;

  factory PlayerResult.fromJson(Map<String, dynamic> json) => PlayerResult(
        nickname: json['nickname'],
        accountId: json['account_id'],
      );

  @override
  Map<String, dynamic> toJson() => {
        'nickname': nickname,
        'account_id': accountId,
      };
}
