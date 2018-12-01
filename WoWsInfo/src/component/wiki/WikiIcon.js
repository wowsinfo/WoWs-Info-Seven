/**
 * WikiIcon.js
 * 
 * A 64x64 icon with a 'New' label 
 */

import React, { Component } from 'react';
import { View, Image, StyleSheet } from 'react-native';
import { LOCAL } from '../../value/data';
import { Touchable } from '../common/Touchable';

class WikiIcon extends Component {
  render() {
    const { container, newLabel } = styles;
    const { item, ...props } = this.props;
    return (
      <Touchable style={container} {...props}>
        <View style={[newLabel, {backgroundColor: DATA[LOCAL.theme][500]}]}/>
        <Image source={{uri: item.image ? item.image : item.icon}} style={{height: 64, width: 64}} resizeMode='contain'/>
      </Touchable>
    )
  };
}

const styles = StyleSheet.create({
  container: {
    alignItems: 'center'
  },
  newLabel: {
    position: 'absolute', zIndex: 1,
    borderRadius: 99, bottom: 0,
    height: 8, width: 8
  }
});

export { WikiIcon };
