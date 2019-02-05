/**
 * ShipStat.js
 * 
 * 
 */

import React, { Component } from 'react';
import { View, Text, StyleSheet } from 'react-native';
import { InfoLabel } from '../common/InfoLabel';
import { roundTo, humanTimeString } from '../../core';
import lang from '../../value/lang';

class ShipStat extends Component {
  render() {
    const { container, horizontal } = styles;
    const { data } = this.props;
    if (!data) return null;

    const { distance, last_battle_time, pvp } = data;
    const { 
      art_agro, max_total_agro, torpedo_agro,
      battles, wins, survived_battles, survived_wins,
      damage_dealt, damage_scouting, max_damage_dealt, max_damage_scouting,
      frags, max_frags_battle,
      planes_killed, max_planes_killed,
      ships_spotted, max_ships_spotted,
      xp, max_xp,
    } = pvp;

    let warshipMode = false;
    if (last_battle_time) warshipMode = true;

    return (
      <View style={container}>
        { warshipMode ? <InfoLabel title={lang.basic_last_battle} info={humanTimeString(last_battle_time)}/> : null }
        <View style={horizontal}>
          <InfoLabel title={'battle'} info={battles}/>
          <InfoLabel title={'battle'} info={survived_battles}/>
        </View>
        <View style={horizontal}>
          <InfoLabel title={'win'} info={wins}/>
          <InfoLabel title={'battle'} info={survived_wins}/>
        </View>
        <View style={horizontal}>
          <InfoLabel title={'damage'} info={roundTo(damage_dealt / battles)}/>
          <InfoLabel title={'battle'} info={max_damage_dealt}/>
        </View>
        <View style={horizontal}>
          <InfoLabel title={'scounting'} info={roundTo(damage_scouting / battles)}/>
          <InfoLabel title={'battle'} info={max_damage_scouting}/>
        </View>
        <View style={horizontal}>
          <InfoLabel title={'potential'} info={roundTo(art_agro / battles)}/>
          <InfoLabel title={'battle'} info={max_total_agro}/>
          <InfoLabel title={'battle'} info={roundTo(torpedo_agro / battles)}/>
        </View>
        <View style={horizontal}>
          <InfoLabel title={'frag'} info={roundTo(frags / battles, 2)}/>
          <InfoLabel title={'battle'} info={max_frags_battle}/>
        </View>
        <View style={horizontal}>
          <InfoLabel title={'plane'} info={roundTo(planes_killed / battles, 2)}/>
          <InfoLabel title={'battle'} info={max_planes_killed}/>
        </View>
        <View style={horizontal}>
          <InfoLabel title={'spotting'} info={roundTo(ships_spotted / battles, 2)}/>
          <InfoLabel title={'battle'} info={max_ships_spotted}/>
        </View>
        <View style={horizontal}>
          <InfoLabel title={'xp'} info={roundTo(xp / battles)}/>
          <InfoLabel title={'battle'} info={max_xp}/>
        </View>
      </View>
    )
  };
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    alignItems: 'center',
    justifyContent: 'center'
  },
  horizontal: {
    flexDirection: 'row'
  }
});

export { ShipStat };
