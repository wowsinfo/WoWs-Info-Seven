import React, { Component } from 'react';
import { View, Text, StyleSheet } from 'react-native';
import { WoWsTouchable } from '../../component';
import { scale } from 'react-native-size-matters';
import { GREY } from 'react-native-material-color';

class TextCell extends Component {
  render() {
    const { title, onPress } = this.props; 
    const { viewStyle, textStyle } = styles
    return (
      <WoWsTouchable onPress={onPress}>
        <View style={viewStyle}>
          <Text style={textStyle}>{title}</Text>
        </View>
      </WoWsTouchable>
    )
  }
}

const styles = StyleSheet.create({
  viewStyle: {
    flexDirection: 'row',
    height: 54,
    alignItems: 'center'
  },
  textStyle: {
    fontWeight: 'bold', fontSize: 14,
    color: GREY[900],
    paddingLeft: 8, width: '100%'
  }
})

export { TextCell };