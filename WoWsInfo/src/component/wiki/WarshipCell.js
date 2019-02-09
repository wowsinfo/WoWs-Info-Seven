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

    let width = 80;
    if (scale) width *= scale;
    return (
      <Touchable style={container} onPress={item ? onPress : null}>
        { item ? 
          <WikiIcon warship item={item} scale={scale}/> : 
          <View style={{height: width / 1.7, width: width}}/> }
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
