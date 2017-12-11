import React from 'react';
import { View, Image, Text, TouchableOpacity, Alert } from 'react-native';
import { WikiCellStyles } from './StylesForAll';

class WikiCell extends React.PureComponent {
  componentWillMount() {
    this.name = this.props.data.name;
    this.icon = this.props.data.icon;
  }

  render() {
    return (
      <View style={viewStyle}>
        <TouchableOpacity onPress={() => this.onWikiBtnPressed()} >
          <Image style={imageStyle} source={{uri: 'https://placeimg.com/128/128/any'}}/>          
        </TouchableOpacity>
        <Text style={textStyle}>{this.name}</Text>
      </View>
    )
  }

  onWikiBtnPressed() {
    Alert.alert('Yaho >_<');
  }
}

const { viewStyle, imageStyle, textStyle } = WikiCellStyles;

export {WikiCell};