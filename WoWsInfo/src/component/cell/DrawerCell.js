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
    const width = android ? 28 : 46;
    return (
      <WoWsTouchable {...props}>
        <View style={viewStyle}>
          <Image source={icon} style={{height: width, width: width, tintColor: android ? getTheme() : null}}/>
          <Text style={textStyle}>{title}</Text>
        </View>
      </WoWsTouchable>
    )
  }
}

const styles = StyleSheet.create({
  viewStyle: {
    flexDirection: 'row',
    height: 54, paddingLeft: android ? 12 : 4,
    alignItems: 'center'
  },
  textStyle: {
    fontWeight: android ? 'bold' : '300',
    paddingLeft: 16, width: '100%'
  }
})

export { DrawerCell };