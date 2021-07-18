/**
 * LoadingIndicator.js
 *
 * A simple loading indicator following current theme
 */

import React, {Component} from 'react';
import {ActivityIndicator, StyleSheet} from 'react-native';
import {isIos} from 'react-native-device-detection';
import {Blue, Grey} from 'react-native-material-color';
import {TintColour} from '../../value/colour';

class LoadingIndicator extends Component {
  render() {
    const {style} = this.props;
    let appTheme = TintColour();
    if (!appTheme) appTheme = Blue;

    return (
      <ActivityIndicator
        size={isIos ? 'small' : 'large'}
        color={!isIos ? appTheme[500] : Grey}
        style={[style, {marginTop: 8}]}
      />
    );
  }
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    alignItems: 'center',
    justifyContent: 'center',
  },
});

export {LoadingIndicator};
