import React from 'react';
import { View, Text, Image } from 'react-native';
import { styles } from './WarshipCellStyles';

class WarshipCell extends React.PureComponent {
  componentWillMount() {
    this.data = this.props.data;
    this.image = this.data.images.small;
    let tierList = ['I', 'II', 'III', 'IV', 'V', 'VI', 'VII', 'VIII', 'IX', 'X'];

    // For Chinese user, replace Japanese ships' name
    var name = tierList[this.data.tier - 1] + ' ';
    if (this.data.nation == 'japan' && global.apiLanguage.includes('zh')) {
      let alias = global.aliasJson[this.data.ship_id];
      // Might be null sometimes if kongzhong.net has not updated their name yet
      if (alias != null) {
        this.tierName = name + alias;
      } else this.tierName = name + this.data.name;
    } else this.tierName = name + this.data.name;
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