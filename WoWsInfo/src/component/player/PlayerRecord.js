/**
 * PlayerRecord.js
 * 
 * 
 */

import React, { Component } from 'react';
import { View, StyleSheet } from 'react-native';
import { Text } from 'react-native-paper';
import { SAVED } from '../../value/data';
import { WarshipCell } from '../wiki/WarshipCell';
import { InfoLabel } from '../common/InfoLabel';

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
    let max = [{num: max_damage_dealt, id: max_damage_dealt_ship_id},
               {num: max_frags_battle, id: max_frags_ship_id},
               {num: max_planes_killed, id: max_planes_killed_ship_id},
               {num: max_xp, id: max_xp_ship_id},
               {num: max_ships_spotted, id: max_ships_spotted_ship_id},
               {num: max_total_agro, id: max_total_agro_ship_id},
               {num: max_damage_scouting, id: max_scouting_damage_ship_id}];

    // Best ships
    let records = [main_battery, second_battery, torpedoes, aircraft, ramming];

    return (
      <View style={container}>
        { records.map(data => this.renderRecord(data)) }
      </View>
    )
  };

  renderRecord(data) {
    const { horizontal, container } = styles;
    const { frags, max_frags_battle, max_frags_ship_id, hits, shots } = data;
    if (!max_frags_ship_id) return null;
    let bestShip = DATA[SAVED.warship][max_frags_ship_id];
    return (
      <View style={horizontal}>
        <View>
          <WarshipCell item={bestShip} scale={1.6}/>
        </View>
        <View>
          <InfoLabel info={frags}/>
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

export { PlayerRecord };
