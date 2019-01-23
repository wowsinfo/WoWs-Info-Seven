import React, { Component } from 'react';
import { StyleSheet, StatusBar } from 'react-native';
import { Router, Stack, Scene, Actions } from 'react-native-router-flux';
import { isTablet } from 'react-native-device-detection';
import { withTheme, DarkTheme, DefaultTheme } from 'react-native-paper';
import { Home, Menu, Settings, About, Setup, Consumable, CommanderSkill, 
  BasicDetail, Achievement, Map as GameMap, Collection, Warship, WarshipDetail, 
  WarshipFilter, WarshipModule } from './page';
import { LOCAL } from './value/data';
import { DataLoader, Downloader } from './core';
import { GREY, BLUE } from 'react-native-material-color';
import { LoadingModal } from './component';
import { TintColour, UpdateTintColour } from './value/colour';

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
      SWAPBUTTON = DATA[LOCAL.swapButton];
      DARKMODE = DATA[LOCAL.darkMode];

      let tint = TintColour();
      if (!tint[50]) tint = BLUE;

      // Setup global dark theme
      global.DARK = {
        colors: {
          ...DarkTheme.colors,
          surface: 'black',
          text: GREY[50],
          primary: tint[500],
          accent: tint[500],
        }
      };

      // Setup global light theme
      global.LIGHT = {
        colors: {
          ...DefaultTheme.colors,
          primary: tint[500],
          accent: tint[500],
        }
      };

      props.theme.roundness = 99;
      props.theme.dark = DARKMODE;
      props.theme.colors = DARKMODE ? DARK.colors : LIGHT.colors;
      console.log(props.theme);

      // Update data here as well, force update when first launch
      let first = DATA[LOCAL.firstLaunch];
      let dn = new Downloader(DATA[LOCAL.userServer]);
      dn.updateAll(first).then(success => {
        // Make sure it finishes downloading
        if (success) {
          this.setState({loading: false, dark: DARKMODE});
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
        <Router sceneStyle={[scene, {backgroundColor: dark ? 'black' : 'white'}]}>
          <Stack key='root' hideNavBar>
            <Scene key='Home' component={Home}/>
            <Scene key='Setup' component={Setup} initial={DATA[LOCAL.firstLaunch]}/>
            
            <Scene key='Menu' component={Menu}/>

            <Scene key='Consumable' component={Consumable}/>
            <Scene key='CommanderSkill' component={CommanderSkill}/>
            <Scene key='Achievement' component={Achievement}/>
            <Scene key='Map' component={GameMap}/>
            <Scene key='Collection' component={Collection}/>
            <Scene key='Warship' component={Warship}/>
            <Scene key='WarshipFilter' component={WarshipFilter}/>
            <Scene key='WarshipDetail' component={WarshipDetail}/>
            <Scene key='WarshipModule' component={WarshipModule}/>
            <Scene key='BasicDetail' component={BasicDetail}/>

            <Scene key='Settings' component={Settings}/>
            <Scene key='About' component={About}/>
          </Stack>
        </Router>
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

export default withTheme(App);
