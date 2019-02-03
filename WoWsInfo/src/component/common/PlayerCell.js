/**
 * PlayerCell.js
 * 
 * 
 */

import React, { Component } from 'react';
import { StyleSheet } from 'react-native';
import { List, Caption, Text } from 'react-native-paper';
import { SafeAction } from '../../core';

class PlayerCell extends Component {
  render() {
    const { item, player, clan } = this.props;
    const { ID } = styles;

    if (player) {
      return <List.Item title={item.nickname} 
        right={() => <Caption style={ID}>{item.account_id}</Caption>}
        onPress={() => this.pushPlayer(item)}/>
    } else if (clan) {
      return <List.Item title={item.tag} 
        right={() => <Caption style={ID}>{item.clan_id}</Caption>}
        onPress={() => null}/>
    } else {
      return <Text>???</Text>;
    }
  };

  pushPlayer(item) {
    SafeAction('Statistics');
  }
}

const styles = StyleSheet.create({
  ID: {
    alignSelf: 'center',
    marginRight: 8
  }
});

export { PlayerCell };
