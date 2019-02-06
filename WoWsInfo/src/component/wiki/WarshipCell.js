/**
 * WarshipCell.js
 * 
 * It is a cell with a WikiIcon and a WarshipLabel below it
 */

import React, { Component } from 'react';
import { View, Text, StyleSheet } from 'react-native';
import { WikiIcon, WarshipLabel } from '../';
import { Touchable } from '../common/Touchable';

class WarshipCell extends Component {
  render() {
    const { container } = styles;
    const { item, scale, onPress } = this.props;
    return (
      <Touchable style={container} onPress={item ? onPress : null}>
        { item ? <WikiIcon warship item={item} scale={scale}/> : null }
        <WarshipLabel item={item}/>
      </Touchable>
    )
  };
}

const styles = StyleSheet.create({
  container: {
    justifyContent: 'center',
    alignItems: 'center'
  }
});

export { WarshipCell };
