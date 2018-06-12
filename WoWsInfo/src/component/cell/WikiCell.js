import React, { Component } from 'react';
import { View, Image, Text, StyleSheet } from 'react-native';
import { WoWsTouchable } from '../../component';;
import { GREY } from 'react-native-material-color';

class WikiCell extends Component {
  render() {
    const { icon, title, ...props } = this.props; 
    const { viewStyle, textStyle } = styles;
    return (
      <WoWsTouchable {...props}>
        <View style={viewStyle}>
          <Image source={icon} style={{width: 36, height: 36}}/>
          <Text style={textStyle}>{title}</Text>
        </View>
      </WoWsTouchable>
    )
  }
}

const styles = StyleSheet.create({
  viewStyle: {
    flexDirection: 'row',
    height: 44, margin: 4, paddingLeft: 8,
    alignItems: 'center'
  },
  textStyle: {
    paddingLeft: 16, width: '100%', color: GREY[900]
  }
})

export { WikiCell };