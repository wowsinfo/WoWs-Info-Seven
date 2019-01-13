/**
 * WarshipModule.js
 * 
 * 
 */

import React, { Component } from 'react';
import { View, Text, StyleSheet } from 'react-native';

class WarshipModule extends Component {
  render() {
    const { container } = styles;
    return (
      <View style={container}>
        <Text>WarshipModule</Text>
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

export { WarshipModule };
