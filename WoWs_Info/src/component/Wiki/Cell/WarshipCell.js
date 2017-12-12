import React from 'react';
import { View, Text, Image } from 'react-native';
import { styles } from './WarshipCellStyles';

class WarshipCell extends React.PureComponent {
  componentWillMount() {
    this.data = this.props.data;
    this.image = this.data.images.small;
    let tierList = ['I', 'II', 'III', 'IV', 'V', 'VI', 'VII', 'VIII', 'IX', 'X'];
    this.tierName = tierList[this.data.tier - 1] + ' ' + this.data.name;
  }

  render() {
    return (
      <View style={viewStyle}>
        <Image source={{uri: this.image, cache: 'default'}} style={imageStyle} resizeMode='contain'/>
        <Text style={textStyle}>{this.tierName}</Text>
      </View>
    )
  }
}

const { viewStyle, imageStyle, textStyle } = styles;

export {WarshipCell};