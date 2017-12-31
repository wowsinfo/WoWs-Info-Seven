import React from 'react';
import { View, Image } from 'react-native';
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
          </View>
        </WoWsTouchable>
      </View>
    )
  }

  showDetail() {
    const { data, collection } = this.props;
    if (collection) Actions.CollectionDetailScreen({data: data, title: data.key});
    else Actions.BasicDetailScreen({data: data, title: data.key});
  }
}

const { viewStyle, imageStyle } = styles;

export {BasicCell};