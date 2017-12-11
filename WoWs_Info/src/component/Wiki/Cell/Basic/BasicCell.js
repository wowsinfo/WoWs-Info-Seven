import React from 'react';
import { View, Image } from 'react-native';
import { styles } from './BasicCellStyles'; 

class BasicCell extends React.PureComponent {
  render() {
    return (
      <View style={viewStyle}>
        <Image source={{uri: this.props.icon}} style={imageStyle}/>
      </View>
    )
  }
}

const { viewStyle, imageStyle } = styles;

export {BasicCell};