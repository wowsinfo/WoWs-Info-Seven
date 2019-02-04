/**
 * TabButton.js
 * 
 * 
 */

import React, { Component } from 'react';
import { View, Text, StyleSheet } from 'react-native';
import { IconButton, Caption } from 'react-native-paper';
import { Touchable } from '../common/Touchable';

class TabButton extends Component {
  render() {
    const { container, text } = styles;
    const { label, onPress, disabled, ...props } = this.props;
    return (
      <Touchable fill style={container} onPress={disabled ? null : onPress}>
        <IconButton size={24} disabled={disabled} {...props}/>
        <Caption style={text}>{label}</Caption>
      </Touchable>
    )
  };
}

const styles = StyleSheet.create({
  container: {
    alignItems: 'center',
    justifyContent: 'center'
  },
  text: {
    marginTop: -14,
  }
});

export { TabButton };
