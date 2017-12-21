import React from 'react';
import { WoWsTouchable } from '../../../component';
import { Actions } from 'react-native-router-flux';
import { styles } from './SearchResultCellStyles';
import { View, Text } from 'react-native';

class SearchResultCell extends React.PureComponent {
  constructor(props) {
    super();
    this.nickname = props.data.nickname;
    this.account_id = props.data.account_id;
  }

  render() {
    const { viewStyle, textStyle } = styles;
    return (
      <View>
        <WoWsTouchable onPress={this.playerInfo}>
          <View style={viewStyle}>
            <Text style={textStyle}>{this.nickname + '|' + this.account_id}</Text> 
          </View>
        </WoWsTouchable>
      </View>
    )
  }

  playerInfo = () => {
    Actions.PlayerScreen({title: this.account_id});
  }
}

export {SearchResultCell};