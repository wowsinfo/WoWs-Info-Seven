import React, { PureComponent } from 'react';
import { View, StyleSheet, FlatList, ScrollView } from 'react-native';
import { List, Text, Colors, IconButton } from 'react-native-paper';
import { LOCAL } from '../../value/data';
import { SafeAction, SafeStorage } from '../../core';

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
    const { container } = styles;
    const { player, clan } = this.state;
    console.log(this.state);
    return (
      <ScrollView style={container}>
        <FlatList data={clan} renderItem={({item, index}) => 
          <List.Item title={item.tag} onPress={() => this.pushToClan(item)}
            right={() => <IconButton color={Colors.grey500} icon='close' onPress={() => this.removeClan(item)}/> }/>}
          keyExtractor={i => i.clan_id} showsVerticalScrollIndicator={false}/>
        <FlatList data={player} renderItem={({item, index}) => 
          <List.Item title={item.nickname} onPress={() => this.pushToPlayer(item)}
            right={() => <IconButton color={Colors.grey500} icon='close' onPress={() => this.removeFriend(item)}/> }/>}
          keyExtractor={i => i.account_id} showsVerticalScrollIndicator={false}/>
      </ScrollView>
    )
  };

  removeFriend(info) {
    let str = LOCAL.friendList;
    delete DATA[str].player[info.account_id];
    SafeStorage.set(str, DATA[str]);
  }

  removeClan(info) {
    let str = LOCAL.friendList;
    delete DATA[str].clan[info.clan_id];
    SafeStorage.set(str, DATA[str]);
  }

  pushToPlayer(info) {
    SafeAction('Statistics', {info: info, friend: true})
  }

  pushToClan(info) {
    SafeAction('ClanInfo', {info: info, friend: true})
  }
}

const styles = StyleSheet.create({
  container: {
    height: '100%'
  }
});

export { Friend };
