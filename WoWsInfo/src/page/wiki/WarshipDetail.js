/**
 * WarshipDetail.js
 * 
 * 
 */

import React, { Component } from 'react';
import { View, FlatList, ScrollView, StyleSheet } from 'react-native';
import { Text } from 'react-native-paper';
import { WoWsInfo, WikiIcon, WarshipCell } from '../../component';
import { SAVED } from '../../value/data';

class WarshipDetail extends Component {
  constructor(props) {
    super(props);

    let curr = props.item;
    console.log(curr);

    // Get all other same tier and same type ships
    let warship = DATA[SAVED.warship];
    let similar = Object.entries(warship).filter(s => {
      if (s[1].tier === curr.tier && s[1].type === curr.type) return true;
    });

    // Remove extra information (ship id)
    similar.forEach((s, i) => similar[i] = Object.assign(s[1]));
    console.log(similar);

    this.state = {
      curr: props.item,
      similar: similar
    };
  }
  render() {
    const { container } = styles;
    const { curr, similar } = this.state;
    return (
      <WoWsInfo>
        <ScrollView>
          <WarshipCell item={curr} scale={3}/>
          <Text>{'t\nt\nt\nt\nt\nt\nt\nt\nt\nt\nt\nt\nt\nt\nt\n'}</Text>
          <Text>{'t\nt\nt\nt\nt\nt\nt\nt\nt\nt\nt\nt\nt\nt\nt\n'}</Text>
          <Text>{'t\nt\nt\nt\nt\nt\nt\nt\nt\nt\nt\nt\nt\nt\nt\n'}</Text>
        </ScrollView>
        <View style={{height: 76}}>
          <FlatList keyExtractor={item => item.name} horizontal data={similar} renderItem={({item}) => {
            return <WarshipCell item={item} scale={1.4} onPress={() => {
              if (item.ship_id === curr.ship_id) return;
              this.setState({curr: item});
            }}/>
          }}/>
        </View>
      </WoWsInfo>
    )
  };
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    alignItems: 'center',
    justifyContent: 'center'
  }
});

export { WarshipDetail };
