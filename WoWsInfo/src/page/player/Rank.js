import React, { Component } from 'react';
import { View, Text, StyleSheet } from 'react-native';

class Rank extends Component {
  render() {
    const { container } = styles;
    return (
      <View style={container}>
        <Text>Rank</Text>
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

export { Rank };
