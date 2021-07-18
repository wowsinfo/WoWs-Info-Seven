/**
 * AppName.js
 *
 * Display app name, app and game version and app logo horizontally
 */

import React, {Component} from 'react';
import {View, Image, Platform, StyleSheet} from 'react-native';
import * as Anime from 'react-native-animatable';
import {Title, Caption, Colors} from 'react-native-paper';
import {lang} from '../../value/lang';
import {LOCAL, APP, isProVersion} from '../../value/data';
import {TintColour} from '../../value/colour';
import {Touchable} from './Touchable';
import {SafeAction} from '../../core';

class AppName extends Component {
  render() {
    const {container, game, appName, horizontal} = styles;

    return (
      <Touchable style={horizontal}>
        <View style={container}>
          <Title
            style={[appName, isProVersion() ? {color: Colors.orange500} : {}]}>
            {lang.app_name}
          </Title>
          <Caption style={game}>{this.getVersion()}</Caption>
        </View>
        <Anime.View
          animation="pulse"
          iterationCount="infinite"
          easing="ease"
          useNativeDriver>
          <Image
            source={require('../../img/Logo.png')}
            style={{height: 64, width: 64, tintColor: TintColour()[500]}}
          />
        </Anime.View>
      </Touchable>
    );
  }

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
    justifyContent: 'center',
  },
  game: {
    marginTop: -8,
  },
  appName: {
    fontWeight: 'bold',
  },
  horizontal: {
    flexDirection: 'row',
    margin: 8,
    marginLeft: 8,
    marginBottom: 0,
  },
});

export {AppName};
