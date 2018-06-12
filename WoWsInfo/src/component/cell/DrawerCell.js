import React, { Component } from 'react';
import { View, Image, Text, StyleSheet } from 'react-native';
import { WoWsTouchable } from '../../component';
import { scale } from 'react-native-size-matters';
import { GREY } from 'react-native-material-color';
import { getTheme } from '../../constant/colour';

class DrawerCell extends Component {
  render() {
    const { icon, title, ...props } = this.props; 
    const { viewStyle, textStyle } = styles;
    return (
      <WoWsTouchable {...props}>
        <View style={viewStyle}>
          <Image source={icon} resizeMode='contain' style={{width: 20, height: 20, tintColor: GREY[600]}}/>
          <Text style={textStyle}>{title}</Text>
        </View>
      </WoWsTouchable>
    )
  }
}

const styles = StyleSheet.create({
  viewStyle: {
    flexDirection: 'row',
    height: 44, paddingLeft: 16,
    alignItems: 'center', backgroundColor: 'white'
  },
  textStyle: {
    paddingLeft: 24, width: '100%', fontWeight: '500'
  }
})

export { DrawerCell };