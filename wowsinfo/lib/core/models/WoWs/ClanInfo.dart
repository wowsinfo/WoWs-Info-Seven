/// This is the `ClanInfo` class
class ClanInfo {
  Data data;

  ClanInfo(json) {
    this.data = Data(json["data"]);
  }
}

/// This is the `Data` class
class Data {
  ClanDetail k2000008934;

  Data(json) {
    this.k2000008934 = json["2000008934"];
  }
}

/// This is the `ClanDetail` class
class ClanDetail {
  int membersCount;
  String name;
  String creatorName;
  int clanId;
  int createdAt;
  int updatedAt;
  String leaderName;
  int creatorId;
  String tag;
  Map<String, Member> member;
  Null oldName;
  bool isClanDisbanded;
  Null renamedAt;
  Null oldTag;
  int leaderId;
  String description;

  ClanDetail(json) {
    this.membersCount = json["members_count"];
    this.name = json["name"];
    this.creatorName = json["creator_name"];
    this.clanId = json["clan_id"];
    this.createdAt = json["created_at"];
    this.updatedAt = json["updated_at"];
    this.leaderName = json["leader_name"];
    this.creatorId = json["creator_id"];
    this.tag = json["tag"];
    this.member = json["members"];
    this.oldName = json["old_name"];
    this.isClanDisbanded = json["is_clan_disbanded"];
    this.renamedAt = json["renamed_at"];
    this.oldTag = json["old_tag"];
    this.leaderId = json["leader_id"];
    this.description = json["description"];
  }
}

/// This is the `Member` class
class Member {
  String role;
  int joinedAt;
  int accountId;
  String accountName;

  Member(json) {
    this.role = json["role"];
    this.joinedAt = json["joined_at"];
    this.accountId = json["account_id"];
    this.accountName = json["account_name"];
  }
}
