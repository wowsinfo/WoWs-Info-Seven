/**
 * PlayerCell.js
 *
 * Dsiplay player and clan with her ID at the right
 */

import React, {Component} from 'react';
import {StyleSheet} from 'react-native';
import {List, Caption, Text} from 'react-native-paper';
import {SafeAction} from '../../core';

class PlayerCell extends Component {
  render() {
    const {item, player, clan, width} = this.props;
    const {ID} = styles;

    if (player) {
      return (
        <List.Item
          title={item.nickname}
          style={{width: width}}
          right={() => <Caption style={ID}>{item.account_id}</Caption>}
          onPress={() => this.pushPlayer(item)}
        />
      );
    } else if (clan) {
      return (
        <List.Item
          title={item.tag}
          style={{width: width}}
          right={() => <Caption style={ID}>{item.clan_id}</Caption>}
          onPress={() => this.pushClan(item)}
        />
      );
    } else {
      return <Text>???</Text>;
    }
  }

  pushPlayer(item) {
    SafeAction('Statistics', {info: item});
  }

  pushClan(item) {
    SafeAction('ClanInfo', {info: item});
  }
}

const styles = StyleSheet.create({
  ID: {
    alignSelf: 'center',
    marginRight: 8,
  },
});

export {PlayerCell};
