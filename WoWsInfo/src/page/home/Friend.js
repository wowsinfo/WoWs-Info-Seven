import React, { Component } from 'react';
import { View, Text, StyleSheet, FlatList } from 'react-native';

class Friend extends Component {
  render() {
    const { container } = styles;
    return (
      <View style={container}>
        <Text>Friend</Text>
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

export { Friend };
