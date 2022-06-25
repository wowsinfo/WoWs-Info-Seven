import 'package:flutter/foundation.dart';
import 'package:wowsinfo/models/encodable.dart';
import 'package:wowsinfo/models/wowsinfo/timestamp.dart';

abstract class SearchResult implements Encodable {
  String get displayName;
  String get id;
}

@immutable
class PlayerResult implements SearchResult {
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

  @override
  String toString() {
    return 'PlayerResult(nickname: $nickname, accountId: $accountId, createdAt: $createdAt)';
  }

  @override
  String get displayName => nickname ?? '-';

  @override
  String get id => accountId?.toString() ?? '-';
}

@immutable
class ClanResult implements SearchResult {
  const ClanResult({
    this.membersCount,
    this.createdAt,
    this.clanId,
    this.tag,
    this.name,
  });

  final int? membersCount;
  final TimeStampDate? createdAt;
  final int? clanId;
  final String? tag;
  final String? name;

  factory ClanResult.fromJson(Map<String, dynamic> json) => ClanResult(
        membersCount: json['members_count'],
        createdAt: json['created_at'] == null
            ? null
            : TimeStampDate(json['created_at']),
        clanId: json['clan_id'],
        tag: json['tag'],
        name: json['name'],
      );

  @override
  Map<String, dynamic> toJson() => {
        'members_count': membersCount,
        'created_at': createdAt?.timeStamp,
        'clan_id': clanId,
        'tag': tag,
        'name': name,
      };

  @override
  String toString() {
    return 'ClanResult(membersCount: $membersCount, createdAt: $createdAt, clanId: $clanId, tag: $tag, name: $name)';
  }

  @override
  String get displayName => tag ?? '-';

  @override
  String get id => clanId?.toString() ?? '-';
}
