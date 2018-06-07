import React, { Component } from 'react';
import { Text, Image, ScrollView, View, StyleSheet } from 'react-native';
import { getTheme } from '../../constant/colour';

export default class BasicDetail extends Component {
  render() {
    const { icon, name, text } = this.props;
    const { viewStyle, imageStyle, textStyle, nameStyle } = styles;  
    let color = getTheme();
    return (
      <ScrollView contentContainerStyle={viewStyle}>
        <Image style={imageStyle} source={{uri: icon}} resizeMode='contain'/>
        <Text style={[nameStyle, {color: color}]}>{name}</Text>
        <Text style={textStyle}>{text}</Text>
      </ScrollView>
    )
  }
}

const styles = StyleSheet.create({
  viewStyle: {
    flexGrow: 1,
    alignItems: 'center',
    justifyContent: 'center',
  },
  textStyle: {
    textAlign: 'center',
    padding: 4,
  },
  nameStyle: {
    fontSize: 18,
    textAlign: 'center',
    padding: 4,
  },
  imageStyle: {
    height: 80, 
    width: 80,
  }
})