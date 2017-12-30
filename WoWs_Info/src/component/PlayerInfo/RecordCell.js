import React from 'react';
import { View, Text, Image } from 'react-native';
import { styles } from './RecordCellStyles';

class RecordCell extends React.PureComponent {
  render() {
    const { title, image, name, number } = this.props.info;
    const { mainViewStyle, titleStyle, subViewStyle, imageStyle, numberStyle, nameStyle, imageViewStyle, numberViewStyle } = styles;
    return (
      <View style={mainViewStyle}>
        <Text style={titleStyle}>{title}</Text>
        <View style={subViewStyle}>
          <View style={imageViewStyle}>
            <Image style={imageStyle} source={{uri: image}}/>
            <Text style={nameStyle}>{name}</Text>          
          </View>
          <Text style={numberStyle}>{number}</Text>            
        </View>           
      </View>
    )
  }
}

export {RecordCell};