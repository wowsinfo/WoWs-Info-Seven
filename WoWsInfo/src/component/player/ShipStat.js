/**
 * ShipStat.js
 * 
 * 
 */

import React, { Component } from 'react';
import { View, Text, StyleSheet } from 'react-native';

class ShipStat extends Component {
  render() {
    const { container } = styles;
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
      ramming
    } = pvp;

    // There are two modes, basic player or ship statistics
    return (
      <View style={container}>
        <Text>ShipStat</Text>
      </View>
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

export { ShipStat };
