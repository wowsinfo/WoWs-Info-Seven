import React, { Component } from 'react';
import { StyleSheet, Alert, BackHandler } from 'react-native';
import { Router, Stack, Scene, Actions } from 'react-native-router-flux';
import { withTheme, DarkTheme, DefaultTheme } from 'react-native-paper';
import { Menu, Settings, About, Setup, Consumable, CommanderSkill, 
  BasicDetail, Achievement, Map as GameMap, Collection, Warship, WarshipDetail, 
  WarshipFilter, WarshipModule, Loading, Statistics, ClanInfo, PlayerAchievement, 
  Rating, Search, Graph, SimilarGraph, License, RS } from './page';
import { LOCAL, getFirstLaunch, getCurrServer } from './value/data';
import { DataLoader, Downloader } from './core';
import { GREY, BLUE } from 'react-native-material-color';
import { TintColour } from './value/colour';
import { lang } from './value/lang';
import { PlayerShip } from './page/player/PlayerShip';
import { Detailed } from './page/player/Detailed';
import { Rank } from './page/player/Rank';

class App extends Component {
  constructor(props) {
    super(props);

    this.state = {
      loading: true,
      dark: false,
    };

    // Load all data from AsyncStorage
    DataLoader.loadAll().then(data => {
      console.log(data);
      
      global.DATA = data;
      SWAPBUTTON = DATA[LOCAL.swapButton];
      DARKMODE = DATA[LOCAL.darkMode];
      NOIMAGEMODE = DATA[LOCAL.noImageMode];
      LASTLOCATION = DATA[LOCAL.lastLocation];

      console.log('state has been set');

      let tint = TintColour();
      if (!tint[50]) tint = BLUE;

      // Setup global dark theme
      global.DARK = {
        colors: {
          ...DarkTheme.colors,
          surface: 'black',
          text: GREY[50],
          primary: tint[500],
          accent: tint[300],
        }
      };

      // Setup global light theme
      global.LIGHT = {
        colors: {
          ...DefaultTheme.colors,
          surface: 'white',
          text: GREY[900],
          primary: tint[500],
          accent: tint[300],
        }
      };

      props.theme.roundness = 24;
      props.theme.dark = DARKMODE;
      props.theme.colors = DARKMODE ? DARK.colors : LIGHT.colors;
      console.log(props.theme);

      let first = getFirstLaunch();
      if (!first) {
        // Update data here if it is not first launch
        let dn = new Downloader(getCurrServer());
        dn.updateAll(false).then(obj => {
          // Since data are loaded even if user is offline, it should be fine
          this.setState({loading: false, dark: DARKMODE});
          // Display message if it is not success
          if (!obj.status) {
            Alert.alert(lang.error_title, lang.error_download_issue + '\n\n' + obj.log);
          }
        });
      } else {
        this.setState({loading: false, dark: DARKMODE});
      }
    });
  }

  render() {
    const { loading, dark } = this.state;
    if (loading) return <Loading />;
    return (
      <Router sceneStyle={{flex: 1, backgroundColor: dark ? 'black' : 'white'}} backAndroidHandler={this.handleBack}>
        <Stack key='root' hideNavBar>
          <Scene key='Menu' component={Menu}/>
          <Scene key='Setup' component={Setup} initial={getFirstLaunch()}/>
          <Scene key='Search' component={Search}/>
          <Scene key='RS' component={RS}/>
          
          <Scene key='Rating' component={Rating} />
          <Scene key='Statistics' component={Statistics} />
          <Scene key='Graph' component={Graph} />
          <Scene key='PlayerAchievement' component={PlayerAchievement} />
          <Scene key='PlayerShip' component={PlayerShip} />
          <Scene key='PlayerShipDetail' component={Detailed} />
          <Scene key='Rank' component={Rank} />
          <Scene key='ClanInfo' component={ClanInfo} />

          <Scene key='Consumable' component={Consumable}/>
          <Scene key='CommanderSkill' component={CommanderSkill}/>
          <Scene key='Achievement' component={Achievement}/>
          <Scene key='Map' component={GameMap}/>
          <Scene key='Collection' component={Collection}/>
          <Scene key='Warship' component={Warship}/>
          <Scene key='WarshipFilter' component={WarshipFilter}/>
          <Scene key='SimilarGraph' component={SimilarGraph}/>
          <Scene key='WarshipDetail' component={WarshipDetail}/>
          <Scene key='WarshipModule' component={WarshipModule}/>
          <Scene key='BasicDetail' component={BasicDetail}/>

          <Scene key='Settings' component={Settings}/>
          <Scene key='License' component={License}/>
          <Scene key='About' component={About}/>
        </Stack>
      </Router>
    );
  }

  handleBack = () => {
    if (Actions.state.routes.length == 1) {
      BackHandler.exitApp();
    }
  }
}

const styles = StyleSheet.create({
  container: {
    flex: 1
  },
});

export default withTheme(App);
