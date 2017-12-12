import React from 'react';
import { View, Image, TouchableWithoutFeedback } from 'react-native';
import { Actions } from 'react-native-router-flux';
import { styles } from './BasicCellStyles'; 

class BasicCell extends React.PureComponent {
  render() {
    return (
      <View style={viewStyle}>
        <TouchableWithoutFeedback onPress={() => this.showDetail()}>
          <Image source={{uri: this.props.icon, cache: 'force-cache'}} style={imageStyle} />
        </TouchableWithoutFeedback>
      </View>
    )
  }

  showDetail() {
    let data = this.props.data;
    Actions.WikiDetailScreen({data: data, title: data.key});
  }
}

const { viewStyle, imageStyle } = styles;

export {BasicCell};