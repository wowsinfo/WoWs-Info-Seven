/**
 * Info6Icon.js
 * 
 * 
 */

import React, { Component } from 'react';
import { View, Text, StyleSheet } from 'react-native';

class Info6Icon extends Component {
  render() {
    const { container } = styles;
    return (
      <View style={container}>
        <Text>Info6Icon</Text>
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

export { Info6Icon };
