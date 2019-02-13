import React, { PureComponent } from 'react';
import { View, StyleSheet, FlatList, ScrollView } from 'react-native';
import { List, Text, Colors, IconButton } from 'react-native-paper';
import { LOCAL } from '../../value/data';
import { SafeAction, SafeStorage, SafeValue } from '../../core';
import { SectionTitle } from '../../component';
import { lang } from '../../value/lang';

class Friend extends PureComponent {
  constructor(props) {
    super(props);
    let all = DATA[LOCAL.friendList];

    let clan = [];
    for (let ID in all.clan) clan.push(all.clan[ID]);
    let player = [];
    for (let ID in all.player) player.push(all.player[ID]);

    this.state = {
      player, clan
    };
  }

  render() {
    const { player, clan } = this.state;
    console.log(this.state);
    return (
      <View>
        <SectionTitle title={`${lang.friend_clan_title} - ${SafeValue(clan.length, 0)}`}/>
        <FlatList data={clan} renderItem={({item}) => 
          <List.Item title={item.tag} onPress={() => this.pushToClan(item)} description={item.clan_id}
            right={() => <IconButton color={Colors.grey500} icon='close' onPress={() => this.removeClan(item)}/> }/>}
        keyExtractor={i => String(i.clan_id)} keyboardShouldPersistTaps='always'/>
        <SectionTitle title={`${lang.friend_player_title} - ${SafeValue(player.length, 0)}`}/>
        <FlatList data={player} renderItem={({item}) => 
          <List.Item title={item.nickname} onPress={() => this.pushToPlayer(item)} description={item.account_id}
            right={() => <IconButton color={Colors.grey500} icon='close' onPress={() => this.removeFriend(item)}/> }/>}
        keyExtractor={i => String(i.account_id)} keyboardShouldPersistTapshenryq='always'/>
      </View>
    )
  };

  removeFriend(info) {
    let str = LOCAL.friendList;
    delete DATA[str].player[info.account_id];
    SafeStorage.set(str, DATA[str]);
    this.setState({player: DATA[str].player});
  }

  removeClan(info) {
    let str = LOCAL.friendList;
    delete DATA[str].clan[info.clan_id];
    SafeStorage.set(str, DATA[str]);
    this.setState({clan: DATA[str].clan});
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
