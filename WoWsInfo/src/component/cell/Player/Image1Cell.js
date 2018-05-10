import React, { Component } from 'react';
import { View, Image, Text, StyleSheet } from 'react-native';

class Image1Cell extends Component {
  render() {
    const { image, text, highlight } = this.props;
    const { imageStyle, textStyle, viewStyle } = styles;    
    return (
      <View style={viewStyle}>
        <Image source={image} style={[imageStyle, highlight]} resizeMethod='resize'/>
        <Text style={textStyle}>{text}</Text>
      </View>
    )
  }
}

const styles = StyleSheet.create({
  imageStyle: {
    height: 42,
    width: 42,
  },
  textStyle: {
    paddingTop: 4,
    fontSize: 16,
    textAlign: 'center',
  },
  viewStyle: {
    flex: 1,
    alignItems: 'center',
    justifyContent: 'center',
  }
})

export { Image1Cell };