import React, { PureComponent } from 'react';
import { View, StyleSheet, FlatList } from 'react-native';
import { List, Colors, IconButton } from 'react-native-paper';
import * as Anime from 'react-native-animatable';
import { LOCAL } from '../../value/data';
import { SafeAction, SafeStorage, SafeValue, random } from '../../core';
import { SectionTitle } from '../../component';
import { lang } from '../../value/lang';

class Friend extends PureComponent {
  constructor(props) {
    super(props);
    let all = DATA[LOCAL.friendList];

    let player = this.getPlayer(all);
    let clan = this.getClan(all);

    this.state = {
      player, clan
    };
  }

  getPlayer = (all) => {
    let player = [];
    for (let ID in all.player) player.push(all.player[ID]);
    return player;
  };
  
  getClan = (all) => {
    let clan = [];
    for (let ID in all.clan) clan.push(all.clan[ID]);
    return clan;
  };

  render() {
    const { player, clan } = this.state;

    const list = ['fadeInLeft', 'fadeInRight'];
    let clanSide = list[random(list.length)];
    let playerSide = list[random(list.length)];

    return (
      <View>
        <Anime.View animation={clanSide} useNativeDriver>
          <SectionTitle title={`${lang.friend_clan_title} - ${SafeValue(clan.length, 0)}`}/>
          <FlatList data={clan} renderItem={({item}) => 
            <List.Item title={item.tag} onPress={() => this.pushToClan(item)} description={item.clan_id}
              right={() => <IconButton color={Colors.grey500} icon='close' onPress={() => this.removeClan(item)}/> }/>}
          keyExtractor={i => String(i.clan_id)} keyboardShouldPersistTaps='always'/>
        </Anime.View>
        <Anime.View animation={playerSide} useNativeDriver>  
          <SectionTitle title={`${lang.friend_player_title} - ${SafeValue(player.length, 0)}`}/>
          <FlatList data={player} renderItem={({item}) => 
            <List.Item title={item.nickname} onPress={() => this.pushToPlayer(item)} description={item.account_id}
              right={() => <IconButton color={Colors.grey500} icon='close' onPress={() => this.removeFriend(item)}/> }/>}
          keyExtractor={i => String(i.account_id)} keyboardShouldPersistTapshenryq='always'/>
        </Anime.View>
      </View>
    )
  };

  removeFriend(info) {
    let str = LOCAL.friendList;
    delete DATA[str].player[info.account_id];
    SafeStorage.set(str, DATA[str]);
    this.setState({player: this.getPlayer(DATA[str])});
  }

  removeClan(info) {
    let str = LOCAL.friendList;
    delete DATA[str].clan[info.clan_id];
    SafeStorage.set(str, DATA[str]);
    this.setState({clan: this.getClan(DATA[str])});
  }

  pushToPlayer(info) {
    SafeAction('Statistics', {info: info})
  }

  pushToClan(info) {
    SafeAction('ClanInfo', {info: info})
  }
}

const styles = StyleSheet.create({
  container: {
    height: '100%'
  }
});

export { Friend };
