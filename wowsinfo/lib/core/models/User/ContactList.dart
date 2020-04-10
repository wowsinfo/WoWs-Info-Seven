import 'package:wowsinfo/core/models/User/Player.dart';
import 'package:wowsinfo/core/models/User/Clan.dart';

/// This stores and manages player contact including players and clans
class ContactList {
  List<Player> players = [];
  addPlayer(Player player) => players.add(player);
  bool containsPlayer(Player player) => this.players.contains(player);

  List<Clan> clans = [];
  addClan(Clan clan) => clans.add(clan);
  bool containsClan(Clan clan) => this.clans.contains(clan);

  ContactList();
  ContactList.fromJson(Map<String, dynamic> json) {
    this.players = (json['players'] as List).map((e) => Player.fromJson(e)).toList();
    this.clans = (json['clans'] as List).map((e) => Clan.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    /// Although `Set` is used, it might be great to 
    return {
      'players': players,
      'clans': clans,
    };
  }
}
