import React, { Component } from 'react';
import { View, Text, SafeAreaView, StyleSheet } from 'react-native';
import { Appbar, Button } from 'react-native-paper';
import { Actions } from 'react-native-router-flux';
import { BackButton } from '../component';

class Settings extends Component {
  render() {
    const { container, bottom } = styles;
    return (
      <View style={container}>
        <BackButton />
      </View>
    )
  };
}

const styles = StyleSheet.create({
  container: {
    flex: 1
  },
  bottom: {
    position: 'absolute',
    left: 0,
    right: 0,
    bottom: 0,
  }
});

export { Settings };
