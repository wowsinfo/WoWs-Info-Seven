/**
 * Setup.js
 * This page is for setuping API language and server
 * It only displays when you first launched WoWs Info
 */

import React, { Component } from 'react';
import { View, SafeAreaView, StyleSheet } from 'react-native';
import { Text, Button, Surface } from 'react-native-paper';
import { Actions } from 'react-native-router-flux';

class Setup extends Component {
  render() {
    const { container } = styles;
    return (
      <Surface style={container}>
        <SafeAreaView style={{flex: 1}}>
          <Text>Setup</Text>
        </SafeAreaView>
        <SafeAreaView>
          <Button onPress={() => Actions.reset('Home')}>Done</Button>
        </SafeAreaView>        
      </Surface>
    )
  };
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
  }
});

export { Setup };
