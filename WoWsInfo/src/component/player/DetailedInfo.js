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
import { SectionTitle } from '../common/SectionTitle';

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
    let playerMode = false;
    if (pvp.max_damage_dealt_ship_id) playerMode = true;
    
    const { more } = this.state;
    return (
      <View style={container}>
        { !playerMode ? <InfoLabel title={lang.basic_last_battle} info={humanTimeString(last_battle_time)}/> : null }
        <Info6Icon data={pvp}/>
        { more ? this.renderMore(playerMode) : <Button onPress={() => this.setState({more: true})}>{lang.basic_more_stat}</Button> }
      </View>
    )
  };

  renderMore(playerMode) {
    const { pvp } = this.props.data;
    return this.renderInfo(pvp, playerMode);
  }

  renderInfo(data, playerMode) {
    const { container, horizontal } = styles;
    console.log(data);
    const { 
      art_agro, torpedo_agro,
      battles, wins, losses, draws, survived_battles, survived_wins,
      damage_dealt, damage_scouting,
      planes_killed,
      ships_spotted,
      xp, frags,
      aircraft, main_battery, ramming, second_battery, torpedoes
    } = data;

    let weapons = [{name: lang.warship_artillery_main, data: main_battery}, {name: lang.warship_artillery_secondary, data: second_battery}, 
      {name: lang.warship_torpedoes, data: torpedoes}, {name: lang.warship_aircraft, data: aircraft}, {name: lang.warship_ramming, data: ramming}];

    return (
      <View style={container}>
        <View style={horizontal}>
          <InfoLabel title={lang.detailed_win} info={wins}/>
          <InfoLabel title={lang.detailed_draw} info={draws}/>
          <InfoLabel title={lang.detailed_loss} info={losses}/>
        </View>
        <View style={horizontal}>
          <InfoLabel title={lang.detailed_survived} info={survived_battles}/>
          <InfoLabel title={lang.detailed_total_xp} info={xp}/>
          <InfoLabel title={lang.detailed_survived_win} info={survived_wins}/>
        </View>
        <View style={horizontal}>
          <InfoLabel title={lang.detailed_survival_rate} info={`${roundTo(survived_battles / battles * 100, 2)}%`}/>
          <InfoLabel title={lang.detailed_survivied_win_rate} info={`${roundTo(survived_wins / survived_battles * 100, 2)}%`}/>
        </View>
        <Space height={16}/>
        { art_agro ? <View style={container}>
          <View style={horizontal}>
            <InfoLabel title={lang.detailed_total_potential_damage} info={art_agro}/>
            <InfoLabel title={lang.detailed_avg_potential_damage} info={roundTo(art_agro / battles)}/>
          </View>
          <View style={horizontal}>
            <InfoLabel title={lang.detailed_total_torp_potential_damage} info={torpedo_agro}/>
            <InfoLabel title={lang.detailed_avg_torp_potential_damage} info={roundTo(torpedo_agro / battles)}/>
          </View>
          <View style={horizontal}>
            <InfoLabel title={lang.detailed_total_scouting_damage} info={damage_scouting}/>
            <InfoLabel title={lang.detailed_avg_scouting_damage} info={roundTo(damage_scouting / battles)}/>
          </View>
          <View style={horizontal}>
            <InfoLabel title={lang.detailed_total_damage} info={damage_dealt}/>
            <InfoLabel title={lang.detailed_damage_potential_ratio} info={`${roundTo(damage_dealt / art_agro * 100, 2)}%`}/>
          </View>
          <Space height={16}/>
          <View style={horizontal}>
            <InfoLabel title={lang.detailed_total_spotted} info={ships_spotted}/>
            <InfoLabel title={lang.detailed_avg_spotted} info={roundTo(ships_spotted / battles, 2)}/>
          </View>
        </View> : null }
        <View style={horizontal}>
          <InfoLabel title={lang.detailed_total_frag} info={frags}/>
          <InfoLabel title={lang.detailed_frag_spot_ratio} info={`${roundTo(frags / ships_spotted * 100, 2)}%`}/>
        </View>
        <View style={horizontal}>
          <InfoLabel title={lang.detailed_total_plane_killed} info={planes_killed}/>
          <InfoLabel title={lang.detailed_avg_plane_killed} info={roundTo(planes_killed / battles, 2)}/>
        </View>
        <Space height={16}/>
        { !playerMode ? weapons.map(d => this.renderShipRecord(d)) : null }
      </View>
    )
  }

  renderShipRecord(weapon) {
    const { data, name } = weapon;
    if (data == null) return null;
    const { container, horizontal } = styles;
    const { frags, max_frags_battle } = weapon.data;
    if (frags == 0) return null;
    return (
      <View style={container} key={name}>
        <SectionTitle title={name}/>
        <View style={horizontal}>
          <InfoLabel title={lang.weapon_total_frags} info={frags}/>
          <InfoLabel title={lang.weapon_max_frags} info={max_frags_battle}/>
        </View>
      </View>
    )
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
