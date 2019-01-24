import React, { Component } from 'react';
import { StyleSheet, StatusBar } from 'react-native';
import { Router, Stack, Scene, Actions } from 'react-native-router-flux';
import { withTheme, DarkTheme, DefaultTheme } from 'react-native-paper';
import { Home, Menu, Settings, About, Setup, Consumable, CommanderSkill, 
  BasicDetail, Achievement, Map as GameMap, Collection, Warship, WarshipDetail, 
  WarshipFilter, WarshipModule } from './page';
import { LOCAL, getFirstLaunch } from './value/data';
import { DataLoader, Downloader } from './core';
import { GREY, BLUE } from 'react-native-material-color';
import { LoadingModal } from './component';
import { TintColour, UpdateTintColour } from './value/colour';

class App extends Component {
  render() {
    return (
      <Router sceneStyle={{flex: 1}}>
        <Stack key='root' hideNavBar>
          <Scene key='Home' component={Home}/>
          <Scene key='Setup' component={Setup} initial={!getFirstLaunch()}/>
          
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
});

export default App;
