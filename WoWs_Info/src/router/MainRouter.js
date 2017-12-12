import React from 'react';
import { StyleSheet, Platform } from 'react-native';
import { Router, Scene, Actions } from 'react-native-router-flux';
import { SearchButton, PlayerOnlineButton } from '../component';
import { SearchScreen, PlayerOnlineScreen, AchievementScreen, CommanderScreen, ConsumableScreen, MapScreen, ShipScreen, WikiDetailScreen } from '../screen';
import { MainTab } from '../tab/';
import strings from '../localization';

var appTitle = 'WoWs Info ';
switch (Platform.OS) {
  case 'ios': appTitle += 'X'; break;
  case 'android': appTitle += 'Y'; break;
  case 'windows': appTitle += 'Z'; break;
  default: break;
}

const MainRouter = () => {
  return (
    <Router sceneStyle={sceneStyle}>
      <Scene key='root' headerTintColor='white' backTitle='' leftButtonTextStyle={{color: 'white'}} titleStyle={titleStyle} navigationBarStyle={{backgroundColor: global.themeColor}}>
        <Scene key='MainScreen' title={appTitle} component={MainTab} navigationBarStyle={{backgroundColor: global.themeColor, elevation: 0}}
          renderRightButton={ <SearchButton onPress={() => Actions.SearchScreen()}/> }
          renderLeftButton={ <PlayerOnlineButton onPress={() => Actions.PlayerOnlineScreen()}/> } />
        <Scene key='SearchScreen' component={SearchScreen}/>
        
        <Scene key='AchievementScreen' component={AchievementScreen}/>
        <Scene key='CommanderScreen' component={CommanderScreen}/>
        <Scene key='ConsumableScreen' component={ConsumableScreen}/>
        <Scene key='MapScreen' component={MapScreen}/>
        <Scene key='ShipScreen' component={ShipScreen}/>

        <Scene key='WikiDetailScreen' component={WikiDetailScreen}/>
        
        <Scene key='PlayerOnlineScreen' component={PlayerOnlineScreen}/>
      </Scene>
    </Router>
  )
}

const styles = StyleSheet.create({
  titleStyle: {
    color: 'white',
    width: '90%',
  },
  sceneStyle: {
    backgroundColor: 'white',
  }
});
const { titleStyle, sceneStyle } = styles;

export {MainRouter};