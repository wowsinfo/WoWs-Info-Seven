/**
 * Touchable.js
 * 
 * A basic touchable view
 */

import React, { Component } from 'react';
import { View, Text, StyleSheet } from 'react-native';
import { TouchableRipple } from 'react-native-paper';

class Touchable extends Component {
  render() {
    const { style, children, ...props } = this.props;
    return (
      <TouchableRipple {...props}>
        <View style={style}>
          { children }
        </View>
      </TouchableRipple>
    )
  };
}

export { Touchable };
