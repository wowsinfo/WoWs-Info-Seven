import React from 'react';
import { Text, Image, ScrollView } from 'react-native';
import { styles } from './WikiDetailScreenStyles';

class WikiDetailScreen extends React.PureComponent {
  componentWillMount() {
    console.log(this.props.data);
    this.image = this.props.data.image;
    this.name = this.props.data.name;
    this.text = this.props.data.text;
  }

  render() {
    return (
      <ScrollView contentContainerStyle={viewStyle}>
        <Image style={imageStyle} source={{uri: this.image}}/>
        <Text style={[nameStyle, {color: global.themeColor}]}>{this.name}</Text>
        <Text style={textStyle}>{this.text}</Text>
      </ScrollView>
    )
  }
}

const { viewStyle, imageStyle, textStyle, nameStyle } = styles;

export {WikiDetailScreen};