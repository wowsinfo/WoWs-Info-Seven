import React, { Component } from 'react';
import { Text, View, Image, ScrollView, StyleSheet, Dimensions } from 'react-native';

export default class MapDetail extends Component {
  render() {
    const { icon, description } = this.props;
    const { viewStyle, imageStyle, textStyle, scrollViewStyle } = styles;    
    return (
      <ScrollView contentContainerStyle={scrollViewStyle}>
        <Image style={imageStyle} source={{uri: icon}}/>
        <Text style={textStyle}>{description}</Text>
      </ScrollView>
    )
  }
}

const { width, height } = Dimensions.get('window');
const imageWidth = (width < height) ? width - 16 : height - 16;
export const styles = StyleSheet.create({
  scrollViewStyle: {
    padding: 8,
    alignItems: 'center',
  },
  imageStyle: {
    width: imageWidth,
    height: imageWidth,
  },
  textStyle: {
    marginTop: 8,
    fontSize: 16,
    textAlign: 'center',
  }
})