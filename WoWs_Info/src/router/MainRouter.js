import React from 'react';
import { StyleSheet, Platform, View, Text } from 'react-native';
import { Router, Scene, Actions, Stack } from 'react-native-router-flux';
import { SearchButton } from '../component';
import { SearchScreen } from '../screen';
import { MainTab } from '../tab/';

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
        <Scene key='MainScreen' title={appTitle} component={MainTab} renderRightButton={ <SearchButton onPress={() => Actions.SearchScreen()}/> } 
        navigationBarStyle={{backgroundColor: global.themeColor, elevation: 0}}/>
        <Scene key='SearchScreen' component={SearchScreen} modal/>
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