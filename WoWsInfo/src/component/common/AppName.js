/**
 * AppName.js
 * 
 * 
 */

import React, { Component } from 'react';
import { View, Image, Platform,StyleSheet } from 'react-native';
import { Title, Caption } from 'react-native-paper';
import { lang } from '../../value/lang';
import { LOCAL, APP } from '../../value/data';
import { TintColour } from '../../value/colour';

class AppName extends Component {
  render() {
    const { container, game, appName, horizontal } = styles;
    return (
      <View style={horizontal}>
        <View style={container}>
          <Title style={appName}>{lang.app_name}</Title>
          <Caption style={game}>{this.getVersion()}</Caption>
        </View>
        <Image source={require('../../img/Logo.png')} style={{height: 64, width: 64, tintColor: TintColour()[500]}}/>
      </View>
    )
  };

  getVersion() {
    let app = APP.Version;
    if (Platform.OS === 'ios') app = APP.IOSVersion;
    return `${app} (${DATA[LOCAL.gameVersion]})`;
  }
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    paddingLeft: 8,
    justifyContent: 'center'
  },
  game: {
    marginTop: -8
  },
  appName: {
    fontWeight: 'bold'
  },
  horizontal: {
    flexDirection: 'row',
    margin: 8,
    marginLeft: 16,
    marginBottom: 0
  }
});

export { AppName };
