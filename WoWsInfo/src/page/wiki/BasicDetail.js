/**
 * BasicDetail.js
 * 
 * This page displays item details for achievements, consumables, 
 * commander skills and collections
 */

import React, { Component } from 'react';
import { View, Text, StyleSheet } from 'react-native';
import { Surface } from 'react-native-paper';

class BasicDetail extends Component {
  render() {
    const { container } = styles;
    return (
      <Surface style={container}>
        <Text>BasicDetail</Text>
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

export { BasicDetail };
