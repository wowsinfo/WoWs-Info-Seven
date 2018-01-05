import React from 'react';
import { WoWsTouchable } from '../../../component';
import { Actions } from 'react-native-router-flux';
import { styles } from './SearchResultCellStyles';
import { View, Text } from 'react-native';
import { FadeInView } from '../../../Animation';

class SearchResultCell extends React.PureComponent {
  render() {
    const { viewStyle, textStyle } = styles;
    const { name, id } = this.props.data;
    return (
      <FadeInView>
        <WoWsTouchable onPress={this.playerInfo}>
          <View style={viewStyle}>
            <Text style={textStyle}>{name + '|' + id}</Text> 
          </View>
        </WoWsTouchable>
      </FadeInView>
    )
  }

  playerInfo = () => {
    const { name, id, server } = this.props.data;
    Actions.PlayerScreen({title: id, playerName: name, id: id, server: server});
  }
}

export {SearchResultCell};