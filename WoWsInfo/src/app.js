import React, { Component } from 'react';
import { StyleSheet, StatusBar, SafeAreaView, ScrollView } from 'react-native';
import { Router, Stack, Scene } from 'react-native-router-flux';
import { isTablet } from 'react-native-device-detection';
import { Surface, Colors } from 'react-native-paper';
import { Home, Menu } from './page';

export default class App extends Component {
  render() {
    const { container } = styles;
    return (
      <Surface style={container}>
        <StatusBar barStyle='dark-content' backgroundColor={Colors.grey200}/>
        <Router>
          <Stack key='root'>
            <Scene key='Home' component={Home} title='Login'/>
            <Scene key='Menu' component={Menu} title='Register'/>
          </Stack>
        </Router>
      </Surface>
    );
  }
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    paddingLeft: isTablet ? '20%' : null,
    paddingRight: isTablet ? '20%': null,
  },
});
