import React from 'react';
import { StyleSheet, Platform } from 'react-native';
import { Router, Scene, Actions } from 'react-native-router-flux';
import { SearchButton, PlayerOnlineButton } from '../component';
import { SearchScreen, PlayerOnlineScreen } from '../screen';
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
      <Scene key='root' headerTintColor='white' titleStyle={titleStyle} navigationBarStyle={{backgroundColor: global.themeColor}}>
        <Scene key='MainScreen' title={appTitle} component={MainTab} backTitle={strings.back} navigationBarStyle={{backgroundColor: global.themeColor, elevation: 0}}
          renderRightButton={ <SearchButton onPress={() => Actions.SearchScreen()}/> }
          renderLeftButton={ <PlayerOnlineButton onPress={() => Actions.PlayerOnlineScreen()}/> } />
        <Scene key='SearchScreen' component={SearchScreen}/>
        <Scene key='PlayerOnlineScreen' component={PlayerOnlineScreen}/>
      </Scene>
    </Router>
  )
}

const styles = StyleSheet.create({
  titleStyle: {
    color: 'white',
  },
  sceneStyle: {
    backgroundColor: 'white',
  }
});
const { titleStyle, sceneStyle } = styles;

export {MainRouter};