/**
 * BasicDetail.js
 * 
 * This page displays item details for achievements, consumables, 
 * commander skills and collections
 */

import React, { Component } from 'react';
import { View, Text, StyleSheet } from 'react-native';

class BasicDetail extends Component {
  render() {
    const { container } = styles;
    return (
      <View style={container}>
        <Text>BasicDetail</Text>
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

export { BasicDetail };
