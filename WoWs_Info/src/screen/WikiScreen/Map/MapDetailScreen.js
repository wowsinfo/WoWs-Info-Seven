import React from 'react';
import { Text, View, Image, ScrollView } from 'react-native';
import { styles } from './MapDetailScreenStyles';

class MapDetailScreen extends React.PureComponent {
  componentWillMount() {
    this.map = this.props.data.icon;
    this.text = this.props.data.description;
  }

  render() {
    return (
      <ScrollView contentContainerStyle={scrollViewStyle}>
        <Image style={imageStyle} source={{uri : this.map}}/>
        <Text style={textStyle}>{this.text}</Text>
      </ScrollView>
    )
  }
}

const { viewStyle, imageStyle, textStyle, scrollViewStyle } = styles;

export {MapDetailScreen};