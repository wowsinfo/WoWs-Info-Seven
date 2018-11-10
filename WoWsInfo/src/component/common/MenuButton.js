import React, { Component } from 'react';
import { View, Text, StyleSheet } from 'react-native';

class MenuButton extends Component {
  render() {
    const { container } = styles;
    return (
      <View style={container}>
        <Text>Hello World</Text>
      </View>
    )
  }
}

const styles = StyleSheet.create({
  container: {
    position: 'absolute',
    bottom: 0, right: 0,
    margin: 16
  }
})

export { MenuButton };