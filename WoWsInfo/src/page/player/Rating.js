/**
 * Rating.js
 * 
 * 
 */

import React, { Component } from 'react';
import { View, Text, StyleSheet } from 'react-native';

class Rating extends Component {
  render() {
    const { container } = styles;
    return (
      <View style={container}>
        <Text>Rating</Text>
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

export { Rating };
