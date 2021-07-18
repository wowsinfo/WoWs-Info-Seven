import React, {PureComponent} from 'react';
import {View, StyleSheet} from 'react-native';
import {List, Colors, IconButton} from 'react-native-paper';
import * as Anime from 'react-native-animatable';
import {LOCAL} from '../../value/data';
import {
  SafeAction,
  SafeStorage,
  SafeValue,
  random,
  bestWidth,
} from '../../core';
import {SectionTitle} from '../../component';
import {lang} from '../../value/lang';
import {FlatGrid} from 'react-native-super-grid';

class Friend extends PureComponent {
  constructor(props) {
    super(props);
    let all = DATA[LOCAL.friendList];

    let player = this.getPlayer(all);
    let clan = this.getClan(all);

    this.state = {
      player,
      clan,
      goodWidth: bestWidth(400),
    };
  }

  updateBestWidth = event => {
    const newWidth = event.nativeEvent.layout.width;
    this.setState({goodWidth: bestWidth(400, newWidth)});
  };

  getPlayer = all => {
    let player = [];
    for (let ID in all.player) player.push(all.player[ID]);
    return player;
  };

  getClan = all => {
    let clan = [];
    for (let ID in all.clan) clan.push(all.clan[ID]);
    return clan;
  };

  render() {
    const {player, clan, goodWidth} = this.state;

    return (
      <View onLayout={this.updateBestWidth}>
        <SectionTitle
          title={`${lang.friend_clan_title} - ${SafeValue(clan.length, 0)}`}
        />
        <View style={styles.wrap}>
          {clan.map(item => (
            <List.Item
              style={{width: goodWidth}}
              title={item.tag}
              onPress={() => this.pushToClan(item)}
              description={`${item.clan_id}`}
              key={String(item.clan_id)}
              right={() => (
                <IconButton
                  color={Colors.grey500}
                  icon="close"
                  onPress={() => this.removeClan(item)}
                />
              )}
            />
          ))}
        </View>
        <SectionTitle
          title={`${lang.friend_player_title} - ${SafeValue(player.length, 0)}`}
        />
        <View style={styles.wrap}>
          {player.map(item => (
            <List.Item
              style={{width: goodWidth}}
              title={item.nickname}
              onPress={() => this.pushToPlayer(item)}
              description={`${item.account_id}`}
              key={String(item.account_id)}
              right={() => (
                <IconButton
                  color={Colors.grey500}
                  icon="close"
                  onPress={() => this.removeFriend(item)}
                />
              )}
            />
          ))}
        </View>
      </View>
    );
  }

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
    SafeAction('Statistics', {info: info});
  }

  pushToClan(info) {
    SafeAction('ClanInfo', {info: info});
  }
}

const styles = StyleSheet.create({
  container: {
    height: '100%',
  },
  wrap: {
    flexDirection: 'row',
    flexWrap: 'wrap',
  },
});

export {Friend};
