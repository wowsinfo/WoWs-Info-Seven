/**
 * Setup.js
 * This page is for setuping API language and server
 * It only displays when you first launched WoWs Info
 */

import React, { Component } from 'react';
import { View, SafeAreaView, ScrollView, StyleSheet } from 'react-native';
import { Text, Button, Surface, Headline, List, RadioButton } from 'react-native-paper';
import { Actions } from 'react-native-router-flux';
import lang from '../../value/lang';
import { LOCAL } from '../../value/data';
import { SafeStorage } from '../../core';

class Setup extends Component {
  render() {
    const { container, top } = styles;
    return (
      <Surface style={container}>
        <SafeAreaView style={top}>
          <ScrollView>
            <Headline>{lang.setup_title}</Headline>
            <List.Section title='Game Server'>
              { /** This is a radio group */}
            </List.Section>
            <List.Section title='API Language'>
              { /** This is another radio group */}              
            </List.Section>
          </ScrollView>
        </SafeAreaView>
        <SafeAreaView>
          <Button onPress={() => this.finishSetup()}>
            {lang.setup_done_button}
          </Button>
        </SafeAreaView>        
      </Surface>
    )
  };

  // Get selection and download data from api
  finishSetup() {
    Actions.reset('Home');

    // Download data

    DATA[LOCAL.firstLaunch] = false;
    SafeStorage.set(LOCAL.firstLaunch, false);
  }
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    padding: 16
  },
  top: {
    flex: 1
  }
});

export { Setup };
