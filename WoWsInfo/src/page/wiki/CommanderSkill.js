/**
 * CommanderSkill.js
 * 
 * Display commander skills in tiers
 */

import React, { Component } from 'react';
import { View, Text, StyleSheet } from 'react-native';
import { Surface } from 'react-native-paper';
import { SAVED } from '../../value/data';

class CommanderSkill extends Component {
  constructor(props) {
    super(props);

    console.log(DATA[SAVED.commanderSkill]);
  }

  render() {
    const { container } = styles;
    return (
      <Surface style={container}>
        <Text>CommanderSkill</Text>
      </Surface>
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

export { CommanderSkill };
