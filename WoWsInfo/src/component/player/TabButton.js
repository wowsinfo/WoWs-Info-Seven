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
    const { icon, color, label, onPress } = this.props;
    return (
      <Touchable style={container} onPress={() => null}>
        <IconButton icon={icon} color={color} size={24}/>
        <Caption style={text}>{label}</Caption>
      </Touchable>
    )
  };
}

const styles = StyleSheet.create({
  container: {
    alignItems: 'center',
    justifyContent: 'center',
  },
  text: {
    marginTop: -14,
  }
});

export { TabButton };
