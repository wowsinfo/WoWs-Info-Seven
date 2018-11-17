import React, { Component } from 'react';
import { View, Text, StyleSheet } from 'react-native';

class Graph extends Component {
  render() {
    const { container } = styles;
    return (
      <View style={container}>
        <Text>Graph</Text>
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

export { Graph };
