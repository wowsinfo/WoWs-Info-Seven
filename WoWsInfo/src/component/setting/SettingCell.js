import React, { Component } from 'react';
import { View, Text, Image, TouchableHighlight, TouchableNativeFeedback, StyleSheet } from 'react-native';
import { Divider } from 'react-native-elements';
import { GREY } from 'react-native-material-color';

class SettingCell extends Component {
  render() {
    const { image, title, subtitle, divider, onPress, ...props } = this.props;
    const { viewIOSStyle, viewAndroidStyle, imageStyle, horizontalViewStyle, textStyle, titleStyle, subtitleStyle } = styles;
    if (!android) {
      // Icon with text
      return (
        <TouchableHighlight onPress={onPress}>
          <View style={viewIOSStyle}>
            <View style={horizontalViewStyle}>
              <Image source={image} style={imageStyle} resizeMode='contain'/>
              <Text style={textStyle}>{title}</Text>
            </View>
            { divider ? <View style={{paddingLeft: 53}}><Divider /></View> : null }
          </View>
        </TouchableHighlight>
      )
    } else {
      // Text with subtitle
      return (
        <TouchableNativeFeedback onPress={onPress}>
          <View>
            <View style={viewAndroidStyle}>
              <Text style={titleStyle}>{title}</Text>
              <Text style={subtitleStyle}>{subtitle}</Text>
            </View>
            { divider ? <Divider /> : null }
          </View>
        </TouchableNativeFeedback>
      )
    }
  }
}

const styles = StyleSheet.create({
  viewIOSStyle: {
    paddingLeft: 8, 
    backgroundColor: '#FFF'
  },
  viewAndroidStyle: {
    padding: 12
  },
  horizontalViewStyle: {
    flexDirection: 'row',
    padding: 8, 
    alignItems: 'center'
  },
  imageStyle: {
    height: 29, width: 29,
    borderRadius: 4, backgroundColor: '#333'
  },
  textStyle: {
    fontSize: 16, flex: 1,
    paddingLeft: 16
  },
  titleStyle: {
    color: GREY[900], 
    fontWeight: '300', fontSize: 16,
  },
  subtitleStyle: {
    fontSize: 14
  }
})

export { SettingCell };