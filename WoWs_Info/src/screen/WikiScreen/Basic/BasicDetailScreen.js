import React from 'react';
import { Text, Image, ScrollView, View } from 'react-native';
import { styles } from './BasicDetailScreenStyles';

class BasicDetailScreen extends React.PureComponent {
  render() {
    const { icon, name, text } = this.props.data;
    const { viewStyle, imageStyle, textStyle, nameStyle } = styles;    
    return (
      <ScrollView contentContainerStyle={viewStyle}>
        <Image style={imageStyle} source={{uri: icon}}/>
        <Text style={[nameStyle, {color: global.themeColour}]}>{name}</Text>
        <Text style={textStyle}>{text}</Text>
      </ScrollView>
    )
  }
}

export {BasicDetailScreen};