import React, { Component } from 'react';
import { View, ScrollView, StyleSheet } from 'react-native';
import { WoWsInfo, WarshipCell } from '../../component';
import { SAVED } from '../../value/data';
import { Actions } from 'react-native-router-flux';
import { SafeAction, roundTo } from '../../core';
import { Text } from 'react-native-paper';

class Detailed extends Component {
  constructor(props) {
    super(props);
    console.log(props.data);
    this.state = {
      data: props.data
    };
  }

  render() {
    const { data } = this.state;
    if (data == null) {
      Actions.pop();
      return null;
    }
    
    const { container } = styles;
    const { pvp, ship_id } = data;
    const ship = DATA[SAVED.warship][ship_id];
    const overall = DATA[SAVED.pr][ship_id];
    return (
      <WoWsInfo onPress={() => SafeAction('WarshipDetail', {item: ship})}>
        <ScrollView>
          <WarshipCell item={ship} scale={3}/>
          { this.renderNumberDiff(pvp, overall) }
        </ScrollView>
      </WoWsInfo>
    )
  };

  renderNumberDiff(data, overall) {
    if (overall == null || data == null) return null;
    const { horizontal } = styles;
    const { battles, wins, damage_dealt, frags } = data;
    const { average_damage_dealt, average_frags, win_rate } = overall;

    let dmgDiff = roundTo(damage_dealt / battles - average_damage_dealt);
    let winrateDiff = roundTo(wins / battles * 100 - win_rate, 2);
    let fragDiff = roundTo(frags / battles - average_frags, 2);

    return (
      <View style={horizontal}>
        <Text>{dmgDiff}</Text>
        <Text>{winrateDiff}</Text>
        <Text>{fragDiff}</Text>
      </View>
    );
  }
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    alignItems: 'center',
    justifyContent: 'center'
  },
  horizontal: {
    flexDirection: 'row',
    justifyContent: 'space-around'
  }
});

export { Detailed };
