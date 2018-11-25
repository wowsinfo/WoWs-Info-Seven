/**
 * WarshipLabel.js
 * 
 * It is a label with ship name, tier and it will be orange if it is a special ship
 */

import React, { Component } from 'react';
import { View, Text, StyleSheet } from 'react-native';

class WarshipLabel extends Component {
  render() {
    const { container } = styles;
    return (
      <View style={container}>
        <Text>WarshipLabel</Text>
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

export { WarshipLabel };
