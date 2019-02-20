/**
 * Info6Icon.js
 * 
 * The classic 6 icons
 */

import React, { Component } from 'react';
import { View, StyleSheet } from 'react-native';
import { IconLabel } from './IconLabel';
import { roundTo } from '../../core';

class Info6Icon extends Component {
  render() {
    const { container, horizontal } = styles;
    const { data, compact, topOnly } = this.props;
    if (!data) return null;

    const { battles, wins, damage_dealt, frags, xp, survived_battles, main_battery } = data;
    const { hits, shots } = main_battery;
    const death = battles - survived_battles; 
    return (
      <View style={[container, compact ? {marginTop: 0, marginBottom: 0} : {marginTop: 16, marginBottom: 16}]}>
        <View style={horizontal}>
          <IconLabel icon={require('../../img/Battle.png')} info={battles}/>
          <IconLabel icon={require('../../img/WinRate.png')} info={`${roundTo(wins / battles * 100, 2)}%`}/>
          <IconLabel icon={require('../../img/Damage.png')} info={roundTo(damage_dealt / battles)}/>
        </View>
        { topOnly ? null : <View style={horizontal}>
          <IconLabel icon={require('../../img/EXP.png')} info={roundTo(xp / battles)}/>
          <IconLabel icon={require('../../img/KillDeathRatio.png')} info={roundTo(frags / death, 2)}/>
          <IconLabel icon={require('../../img/HitRatio.png')} info={`${roundTo(hits / shots * 100, 2)}%`}/>
        </View> }
      </View>
    )
  };
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    alignItems: 'center',
    justifyContent: 'center',
  },
  horizontal: {
    flexDirection: 'row'
  }
});

export { Info6Icon };
