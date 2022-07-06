import 'package:flutter/foundation.dart';
import 'package:wowsinfo/models/wowsinfo/timestamp.dart';

@immutable
class ClanInformation {
  const ClanInformation({
    this.membersCount,
    this.name,
    this.creatorName,
    this.createdAt,
    this.tag,
    this.updatedAt,
    this.leaderName,
    this.membersIds,
    this.creatorId,
    this.clanId,
    this.members,
    this.oldName,
    this.isClanDisbanded,
    this.renamedAt,
    this.oldTag,
    this.leaderId,
    this.description,
  });

  final int? membersCount;
  final String? name;
  final String? creatorName;
  final TimeStampDate? createdAt;
  final String? tag;
  final TimeStampDate? updatedAt;
  final String? leaderName;
  final List<int>? membersIds;
  final int? creatorId;
  final int? clanId;
  final Map<String, ClanMember>? members;
  final String? oldName;
  final bool? isClanDisbanded;
  final TimeStampDate? renamedAt;
  final String? oldTag;
  final int? leaderId;
  final String? description;

  factory ClanInformation.fromJson(Map<String, dynamic> json) {
    if (json.isEmpty) return const ClanInformation();

    final clan = json.values.first;
    if (clan is Map<String, dynamic>) {
      return ClanInformation(
        membersCount: clan['members_count'],
        name: clan['name'],
        creatorName: clan['creator_name'],
        createdAt: clan['created_at'] == null
            ? null
            : TimeStampDate(clan['created_at']),
        tag: clan['tag'],
        updatedAt: clan['updated_at'] == null
            ? null
            : TimeStampDate(clan['updated_at']),
        leaderName: clan['leader_name'],
        membersIds: clan['members_ids'] == null
            ? null
            : List<int>.from(clan['members_ids']),
        creatorId: clan['creator_id'],
        clanId: clan['clan_id'],
        members: clan['members'] == null
            ? null
            : Map.from(clan['members']).map((k, v) =>
                MapEntry<String, ClanMember>(k, ClanMember.fromJson(v))),
        oldName: clan['old_name'],
        isClanDisbanded: clan['is_clan_disbanded'],
        renamedAt: clan['renamed_at'] == null
            ? null
            : TimeStampDate(clan['renamed_at']),
        oldTag: clan['old_tag'],
        leaderId: clan['leader_id'],
        description: clan['description'],
      );
    }

    assert(false, 'Clan is valid, but there is no information');
    return const ClanInformation();
  }

  @override
  String toString() {
    return 'ClanInformation(membersCount: $membersCount, name: $name, creatorName: $creatorName, createdAt: $createdAt, tag: $tag, updatedAt: $updatedAt, leaderName: $leaderName, membersIds: $membersIds, creatorId: $creatorId, clanId: $clanId, members: $members, oldName: $oldName, isClanDisbanded: $isClanDisbanded, renamedAt: $renamedAt, oldTag: $oldTag, leaderId: $leaderId, description: $description)';
  }
}

@immutable
class ClanMember {
  const ClanMember({
    this.role,
    this.joinedAt,
    this.accountId,
    this.accountName,
  });

  final String? role;
  final TimeStampDate? joinedAt;
  final int? accountId;
  final String? accountName;

  // TODO: map roles to the correct enum
  // final roleValues = EnumValues({
  // 'commander': Role.COMMANDER,
  // 'commissioned_officer': Role.COMMISSIONED_OFFICER,
  // 'executive_officer': Role.EXECUTIVE_OFFICER,
  // 'officer': Role.OFFICER,
  // 'private': Role.PRIVATE,
  // 'recruitment_officer': Role.RECRUITMENT_OFFICER
// });

  factory ClanMember.fromJson(Map<String, dynamic> json) => ClanMember(
        role: json['role'],
        joinedAt:
            json['joined_at'] == null ? null : TimeStampDate(json['joined_at']),
        accountId: json['account_id'],
        accountName: json['account_name'],
      );
}
