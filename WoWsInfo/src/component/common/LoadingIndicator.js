/**
 * LoadingIndicator.js
 * 
 * 
 */

import React, { Component } from 'react';
import { ActivityIndicator, StyleSheet } from 'react-native';
import { isIos } from 'react-native-device-detection';
import { LOCAL } from '../../value/data';
import { Blue, Grey} from 'react-native-material-color';
import { TintColour } from '../../value/colour';

class LoadingIndicator extends Component {
  render() {
    //<ActivityIndicator color='white' size='large'/>
    const { style } = this.props;
    let appTheme = TintColour();
    if (!appTheme) appTheme = Blue;

    return <ActivityIndicator size={isIos ? 'small' : 'large'} 
      color={!isIos ? appTheme[500] : Grey} style={style} />;
  };
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    alignItems: 'center',
    justifyContent: 'center'
  }
});

export { LoadingIndicator };
