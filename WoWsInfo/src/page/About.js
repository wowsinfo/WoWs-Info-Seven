import React, { Component } from 'react';
import { View, StyleSheet } from 'react-native';
import { Surface, Text } from 'react-native-paper';
import { BackButton } from '../component';

class About extends Component {
  render() {
    const { container } = styles;
    return (
      <Surface style={container}>
        <Text>About</Text>
        <BackButton />
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

export { About };
