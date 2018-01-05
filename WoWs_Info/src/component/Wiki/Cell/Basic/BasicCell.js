import React from 'react';
import { View, Image, Text } from 'react-native';
import { WoWsTouchable } from '../../../../component';
import { Actions } from 'react-native-router-flux';
import { styles } from './BasicCellStyles'; 

class BasicCell extends React.PureComponent {
  render() {
    return (
      <View>
        <WoWsTouchable onPress={() => this.showDetail()}>
          <View style={viewStyle}>
            <Image source={{uri: this.props.icon}} style={imageStyle} />
            { this.renderCount() }
          </View>
        </WoWsTouchable>
      </View>
    )
  }

  renderCount() {
    const { data, collection } = this.props;
    if (!collection && data.count != null) {
      return (
        <Text style={textStyle}>{data.count}</Text>
      )
    } else return null;
  }

  showDetail() {
    const { data, collection } = this.props;
    if (collection) Actions.CollectionDetailScreen({data: data, title: data.key});
    else Actions.BasicDetailScreen({data: data, title: data.key});
  }
}

const { viewStyle, imageStyle, textStyle } = styles;

export {BasicCell};