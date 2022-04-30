// To parse this JSON data, do
//
//     final clanResult = clanResultFromJson(jsonString);

import 'package:flutter/foundation.dart';
import 'package:wowsinfo/models/encodable.dart';
import 'package:wowsinfo/models/wowsinfo/timestamp.dart';

@immutable
class ClanResult implements Encodable {
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
}
