/**
 * Consumable.js
 * 
 * Display flag and camouflage or upgrade.
 * There are two modes for this page
 */

import React, { Component } from 'react';
import { View, Text, StyleSheet } from 'react-native';
import { Surface } from 'react-native-paper';

class Consumable extends Component {
  render() {
    const { container } = styles;
    const { upgrade } = this.props;
    return (
      <Surface style={container}>
        <Text>{upgrade ? 'Upgrade' : 'Flag'}</Text>
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

export { Consumable };
