import 'package:flutter/foundation.dart';

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
  final int? createdAt;
  final String? tag;
  final int? updatedAt;
  final String? leaderName;
  final List<int>? membersIds;
  final int? creatorId;
  final int? clanId;
  final Map<String, ClanMember>? members;
  final String? oldName;
  final bool? isClanDisbanded;
  final int? renamedAt;
  final String? oldTag;
  final int? leaderId;
  final String? description;

  factory ClanInformation.fromJson(Map<String, dynamic> json) =>
      ClanInformation(
        membersCount: json['members_count'],
        name: json['name'],
        creatorName: json['creator_name'],
        createdAt: json['created_at'],
        tag: json['tag'],
        updatedAt: json['updated_at'],
        leaderName: json['leader_name'],
        membersIds: json['members_ids'] == null
            ? null
            : List<int>.from(json['members_ids']),
        creatorId: json['creator_id'],
        clanId: json['clan_id'],
        members: json['members'] == null
            ? null
            : Map.from(json['members']).map((k, v) =>
                MapEntry<String, ClanMember>(k, ClanMember.fromJson(v))),
        oldName: json['old_name'],
        isClanDisbanded: json['is_clan_disbanded'],
        renamedAt: json['renamed_at'],
        oldTag: json['old_tag'],
        leaderId: json['leader_id'],
        description: json['description'],
      );
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
  final int? joinedAt;
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
        joinedAt: json['joined_at'],
        accountId: json['account_id'],
        accountName: json['account_name'],
      );
}
