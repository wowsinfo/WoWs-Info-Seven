import React, { Component } from 'react';
import { StyleSheet, Alert, BackHandler } from 'react-native';
import { Router, Stack, Scene, Actions } from 'react-native-router-flux';
import { withTheme, DarkTheme, DefaultTheme } from 'react-native-paper';
import { Home, Menu, Settings, About, Setup, Consumable, CommanderSkill, 
  BasicDetail, Achievement, Map as GameMap, Collection, Warship, WarshipDetail, 
  WarshipFilter, WarshipModule, Loading, Statistics, ClanInfo, PlayerAchievement, 
  Rating, Search, Graph } from './page';
import { LOCAL, getFirstLaunch, getCurrServer } from './value/data';
import { DataLoader, Downloader, SafeStorage } from './core';
import { GREY, BLUE } from 'react-native-material-color';
import { LoadingModal } from './component';
import { TintColour, UpdateTintColour } from './value/colour';
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

      let userLang = DATA[LOCAL.userLanguage];
      if (userLang !== '') lang.setLanguage(userLang);

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

      props.theme.roundness = 32;
      props.theme.dark = DARKMODE;
      props.theme.colors = DARKMODE ? DARK.colors : LIGHT.colors;
      console.log(props.theme);

      let first = getFirstLaunch();
      if (!first) {
        // Update data here if it is not first launch
        let dn = new Downloader(getCurrServer());
        dn.updateAll(false).then(success => {
          // Make sure it finishes downloading
          if (success) {
            this.setState({loading: false, dark: DARKMODE});
          } else {
            // Reset to a special page
            // For now, just an error message
            Alert.alert(lang.error_title, lang.error_download_issue);
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
          <Scene key='WarshipDetail' component={WarshipDetail}/>
          <Scene key='WarshipModule' component={WarshipModule}/>
          <Scene key='BasicDetail' component={BasicDetail}/>

          <Scene key='Settings' component={Settings}/>
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
