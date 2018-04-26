import React, { Component } from 'react';
import { View, Image, ActivityIndicator, StyleSheet } from 'react-native';
import { DataStorage } from '../core';
import { Blue } from 'react-native-material-color';
import { scale } from 'react-native-size-matters';

export default class WoWsInfo extends Component {
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
    height: scale(128),
    width: scale(128),
    margin: 16,
  }
})