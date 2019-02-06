/**
 * PlayerRecord.js
 * 
 * 
 */

import React, { Component } from 'react';
import { View, StyleSheet } from 'react-native';
import { Text, Title } from 'react-native-paper';
import { SAVED } from '../../value/data';
import { WarshipCell } from '../wiki/WarshipCell';
import { InfoLabel } from '../common/InfoLabel';
import { roundTo, SafeAction } from '../../core';
import lang from '../../value/lang';
import { SectionTitle } from '../common/SectionTitle';

class PlayerRecord extends Component {
  render() {
    const { container } = styles;
    const { data } = this.props;
    if (!data) return null;
    
    const { 
      aircraft, main_battery, ramming, second_battery, torpedoes,
      max_damage_dealt, max_damage_dealt_ship_id,
      max_frags_battle, max_frags_ship_id,
      max_planes_killed, max_planes_killed_ship_id,
      max_ships_spotted, max_ships_spotted_ship_id,
      max_xp, max_xp_ship_id,
      max_damage_scouting, max_scouting_damage_ship_id,
      max_total_agro, max_total_agro_ship_id
    } = data;

    // Max records
    let max = [{name: lang.record_max_damage_dealt, num: max_damage_dealt, id: max_damage_dealt_ship_id},
               {name: lang.record_max_frags_battle, num: max_frags_battle, id: max_frags_ship_id},
               {name: lang.record_max_planes_killed, num: max_planes_killed, id: max_planes_killed_ship_id},
               {name: lang.record_max_xp, num: max_xp, id: max_xp_ship_id},
               {name: lang.record_max_ships_spotted, num: max_ships_spotted, id: max_ships_spotted_ship_id},
               {name: lang.record_max_total_agro, num: max_total_agro, id: max_total_agro_ship_id},
               {name: lang.record_max_damage_scouting, num: max_damage_scouting, id: max_scouting_damage_ship_id}];

    // Best ships
    let records = [{name: '', data: main_battery}, {name: '', data: second_battery}, 
                   {name: '', data: torpedoes}, {name: '', data: aircraft}, {name: '', data: ramming}];

    return (
      <View style={container}>
        <SectionTitle title={lang.record_title}/>
        { max.map(data => this.renderMax(data)) }
        { records.map(data => this.renderRecord(data)) }
      </View>
    )
  };

  renderMax(data) {
    const { record, container } = styles;
    const { num, id, name } = data;
    let ship = DATA[SAVED.warship][id];
    if (!ship) return null;
    return (
      <View style={record} key={id}>
        <View style={container}>
          <WarshipCell item={ship} scale={1.6} onPress={() => SafeAction('WarshipDetail', {item: ship})}/>
        </View>
        <View style={container}>
          <InfoLabel title={name} info={num}/>
        </View>
      </View>
    );
  }

  renderRecord(item) {
    const { record, container } = styles;
    const { name, data } = item;
    const { frags, max_frags_battle, max_frags_ship_id, hits, shots } = data;
    let bestShip = DATA[SAVED.warship][max_frags_ship_id];
    if (!bestShip) return null;
    return (
      <View style={container}>
        <SectionTitle title={'Testing'}/>
        <View style={record} key={name}>
          <View style={container}>
            <WarshipCell item={bestShip} scale={1.6} onPress={() => SafeAction('WarshipDetail', {item: bestShip})}/>
          </View>
          <View style={container}>
            <InfoLabel title={lang.weapon_total_frags} info={frags}/>
            <InfoLabel title={lang.weapon_max_frags} info={max_frags_battle}/>
            { hits ? <InfoLabel title={lang.weapon_hit_ratio} info={`${roundTo(hits / shots * 100, 2)}%`}/> : null }
          </View>
        </View>
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
  record: {
    flexDirection: 'row',
    justifyContent: 'space-around'
  }
});

export { PlayerRecord };
