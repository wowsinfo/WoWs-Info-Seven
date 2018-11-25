/**
 * WarshipCell.js
 * 
 * It is a cell with a WikiIcon and a WarshipLabel below it
 */

import React, { Component } from 'react';
import { View, Text, StyleSheet } from 'react-native';

class WarshipCell extends Component {
  render() {
    const { container } = styles;
    return (
      <View style={container}>
        <Text>WarshipCell</Text>
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

export { WarshipCell };
