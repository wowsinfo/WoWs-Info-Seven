import React from 'react';
import { StyleSheet, Platform } from 'react-native';
import { Router, Scene } from 'react-native-router-flux';
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
    <Router>
      <Scene key='root' titleStyle={titleStyle} navigationBarStyle={{backgroundColor: global.themeColor}}>
        <Scene key='MainScreen' title={appTitle} component={MainTab}/>          
      </Scene>
    </Router>
  )
}

const styles = StyleSheet.create({
  titleStyle: {
    color: 'white',
  }
});

const { titleStyle } = styles;

export {MainRouter};