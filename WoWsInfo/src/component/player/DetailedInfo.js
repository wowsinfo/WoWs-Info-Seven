/**
 * DetailedInfo.js
 * 
 * 
 */

import React, { Component } from 'react';
import { View, Text, StyleSheet } from 'react-native';
import { InfoLabel } from '../common/InfoLabel';
import { roundTo, humanTimeString } from '../../core';
import lang from '../../value/lang';
import { IconLabel } from './IconLabel';
import { Info6Icon } from './Info6Icon';
import { Button } from 'react-native-paper';
import { Space } from '../common/Space';
import { Router } from 'react-native-router-flux';

class DetailedInfo extends Component {
  constructor(props) {
    super(props);
    this.state = {
      more: props.more
    };
  }

  render() {
    const { container } = styles;
    const { data } = this.props;
    if (!data) return null;

    const { last_battle_time, pvp } = data;
    let warshipMode = false;
    if (last_battle_time) warshipMode = true;
    
    const { more } = this.state;
    return (
      <View style={container}>
        { warshipMode ? <InfoLabel title={lang.basic_last_battle} info={humanTimeString(last_battle_time)}/> : null }
        <Info6Icon data={pvp}/>
        { more ? this.renderMore(warshipMode) : <Button onPress={() => this.setState({more: true})}>{lang.basic_more_stat}</Button> }
      </View>
    )
  };

  renderMore(warshipMode) {
    if (warshipMode) {
      
    } else {
      const { pvp } = this.props.data;
      return this.renderPlayerInfo(pvp);
    }
  }

  renderPlayerInfo(data) {
    const { container, horizontal } = styles;
    console.log(data);
    const { 
      art_agro, torpedo_agro,
      battles, wins, losses, draws, survived_battles, survived_wins,
      damage_dealt, damage_scouting,
      planes_killed,
      ships_spotted,
      xp, frags
    } = data;
    return (
      <View style={container}>
        <View style={horizontal}>
          <InfoLabel title={'win'} info={wins}/>
          <InfoLabel title={'draw'} info={draws}/>
          <InfoLabel title={'loss'} info={losses}/>
        </View>
        <View style={horizontal}>
          <InfoLabel title={'survived'} info={survived_battles}/>
          <InfoLabel title={'total xp'} info={xp}/>
          <InfoLabel title={'survived win'} info={survived_wins}/>
        </View>
        <View style={horizontal}>
          <InfoLabel title={'survival rate'} info={`${roundTo(survived_battles / battles * 100, 2)}%`}/>
          <InfoLabel title={'survival win rate'} info={`${roundTo(survived_wins / battles * 100, 2)}%`}/>
        </View>
        <Space height={16}/>
        <View style={horizontal}>
          <InfoLabel title={'total potential'} info={art_agro}/>
          <InfoLabel title={'avg potential'} info={roundTo(art_agro / battles)}/>
        </View>
        <View style={horizontal}>
          <InfoLabel title={'scouting damage'} info={damage_scouting}/>
          <InfoLabel title={'avg scouting damage'} info={roundTo(damage_scouting / battles)}/>
        </View>
        <View style={horizontal}>
          <InfoLabel title={'total torp potiential'} info={torpedo_agro}/>
          <InfoLabel title={'avg torp potiential'} info={roundTo(torpedo_agro / battles)}/>
        </View>
        <View style={horizontal}>
          <InfoLabel title={'total damage'} info={damage_dealt}/>
          <InfoLabel title={'real / potential'} info={`${roundTo(damage_dealt / art_agro * 100, 2)}%`}/>
        </View>
        <Space height={16}/>
        <View style={horizontal}>
          <InfoLabel title={'total spotted'} info={ships_spotted}/>
          <InfoLabel title={'avg spotted'} info={roundTo(ships_spotted / battles, 2)}/>
        </View>
        <View style={horizontal}>
          <InfoLabel title={'total frags'} info={frags}/>
          <InfoLabel title={'frag/spot'} info={`${roundTo(frags / ships_spotted * 100, 2)}%`}/>
        </View>
        <Space height={16}/>
        <View style={horizontal}>
          <InfoLabel title={'total plane destroyed'} info={planes_killed}/>
          <InfoLabel title={'avg plane destroyed'} info={roundTo(planes_killed / battles, 2)}/>
        </View>
        <View style={horizontal}>
        </View>
        <View style={horizontal}>
        </View>
        <View style={horizontal}>
        </View>
      </View>
    )
  }

  renderShipInfo() {

  }
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

export { DetailedInfo };
