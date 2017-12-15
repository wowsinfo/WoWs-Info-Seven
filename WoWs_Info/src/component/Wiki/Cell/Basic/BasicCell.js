import React from 'react';
import { View, Image, TouchableWithoutFeedback, TouchableNativeFeedback, Platform } from 'react-native';
import { Actions } from 'react-native-router-flux';
import { styles } from './BasicCellStyles'; 

const Touchable = (Platform.OS == 'android') ? TouchableNativeFeedback : TouchableWithoutFeedback;

class BasicCell extends React.PureComponent {
  render() {
    return (
      <View>
        <Touchable onPress={() => this.showDetail()}>
          <View style={viewStyle}>
            <Image source={{uri: this.props.icon}} style={imageStyle} />
          </View>
        </Touchable>
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