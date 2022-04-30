import 'package:flutter/foundation.dart';
import 'package:wowsinfo/models/encodable.dart';
import 'package:wowsinfo/models/wowsinfo/timestamp.dart';

/// The search result with a given nickname.
@immutable
class PlayerResult implements Encodable {
  const PlayerResult({
    this.nickname,
    this.accountId,
    this.createdAt,
  });

  final String? nickname;
  final int? accountId;
  final TimeStampDate? createdAt;

  factory PlayerResult.fromJson(Map<String, dynamic> json) => PlayerResult(
        nickname: json['nickname'],
        accountId: json['account_id'],
        createdAt: json['created_at'] == null
            ? null
            : TimeStampDate(json['created_at']),
      );

  @override
  Map<String, dynamic> toJson() => {
        'nickname': nickname,
        'account_id': accountId,
        'created_at': createdAt?.timeStamp,
      };
}
