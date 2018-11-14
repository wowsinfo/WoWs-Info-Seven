import React, { Component } from 'react';
import { StyleSheet } from 'react-native';
import { Router, Stack, Scene } from 'react-native-router-flux';
import { isTablet } from 'react-native-device-detection';
import { Surface, Colors } from 'react-native-paper';
import { Home, Menu, Settings } from './page';

export default class App extends Component {
  render() {
    const { container, scene } = styles;
    return (
      <Surface style={container}>
        <Router sceneStyle={[scene, {backgroundColor: 'white'}]}>
          <Stack key='root' hideNavBar>
            <Scene key='Home' component={Home}/>
            <Scene key='Menu' component={Menu}/>
            <Scene key='Settings' component={Settings}/>
          </Stack>
        </Router>
      </Surface>
    );
  }
}

const styles = StyleSheet.create({
  container: {
    flex: 1
  },
  scene: {
    flex: 1,
    paddingLeft: isTablet ? '20%' : null,
    paddingRight: isTablet ? '20%': null,
  },
});
