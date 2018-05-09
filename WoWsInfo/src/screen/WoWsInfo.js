import React, { Component } from 'react';
import { View, Image, ActivityIndicator, StyleSheet } from 'react-native';
import { Blue } from 'react-native-material-color';
import { verticalScale } from 'react-native-size-matters';

export default class WoWsInfo extends Component {
  static navigatorStyle = {
    navBarHidden: true, tabBarHidden: true
  }

  render() {
    const { viewStyle, imageStyle } = styles;
    return (
      <View style={viewStyle}>
        <Image style={imageStyle} source={require('../img/Logo.png')}/>
        <ActivityIndicator size='large' color='white'/>
      </View>
    )
  }
}

const styles = StyleSheet.create({
  viewStyle: {
    backgroundColor: Blue,
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center'
  },
  imageStyle: {
    height: 128, width: 128,
    margin: 16,
  }
})