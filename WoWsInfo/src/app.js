import React, { Component } from 'react';
import { StyleSheet, StatusBar } from 'react-native';
import { Router, Stack, Scene } from 'react-native-router-flux';
import { isTablet } from 'react-native-device-detection';
import { Surface, DarkTheme, DefaultTheme, withTheme } from 'react-native-paper';
import { Home, Menu, Settings, About, Setup, Consumable, CommanderSkill, BasicDetail, Achievement } from './page';
import { LOCAL } from './value/data';
import { DataLoader, Downloader } from './core';
import { GREY } from 'react-native-material-color';
import { LoadingModal } from './component';

class App extends Component {
  constructor(props) {
    super(props);

    this.state = {
      loading: true,
      updating: true,
      dark: false
    };

    // Load all data from AsyncStorage
    DataLoader.loadAll().then(data => {
      console.log(data);
      global.DATA = data;
      const appTheme = DATA[LOCAL.theme];
      const darkMode = DATA[LOCAL.darkMode];

      // Setup global dark theme
      global.DARK = {
        colors: {
          ...DarkTheme.colors,
          surface: 'black',
          text: GREY[50],
          primary: appTheme[500],
          accent: appTheme[500],
        }
      };
      // Setup global light theme
      global.LIGHT = {
        colors: {
          ...DefaultTheme.colors,
          primary: appTheme[500],
          accent: appTheme[500],
        }
      };

      props.theme.roundness = 99;
      props.theme.dark = darkMode;
      props.theme.colors = darkMode ? DARK.colors : LIGHT.colors;

      // Update data here as well, force update when first launch
      let first = DATA[LOCAL.firstLaunch];
      let dn = new Downloader(DATA[LOCAL.userServer]);
      dn.updateAll(first).then(success => {
        // Make sure it finishes downloading
        if (success) {
          this.setState({loading: false, dark: darkMode});
        } else {
          // Reset to a special page
        }
      });
    });
  }

  render() {
    const { container, scene } = styles;
    const { loading, updating, dark } = this.state;
    if (loading) return <LoadingModal />
    return (
      <Surface style={container}>
        <StatusBar barStyle={dark ? 'light-content' : 'dark-content'} 
          backgroundColor={dark ? 'black' : GREY[200]}/>
        <Router sceneStyle={scene}>
          <Stack key='root' hideNavBar>
            <Scene key='Home' component={Home}/>
            <Scene key='Setup' component={Setup} initial={DATA[LOCAL.firstLaunch]}/>
            
            <Scene key='Menu' component={Menu}/>

            <Scene key='Consumable' component={Consumable}/>
            <Scene key='CommanderSkill' component={CommanderSkill}/>
            <Scene key='Achievement' component={Achievement}/>
            <Scene key='BasicDetail' component={BasicDetail}/>

            <Scene key='Settings' component={Settings}/>
            <Scene key='About' component={About}/>
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
    backgroundColor: 'transparent'
  },
});

export default withTheme(App);
