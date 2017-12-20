import React from 'react';
import { WoWsTouchable } from '../../../component';
import { Actions } from 'react-native-router-flux';
import { styles } from './SearchResultCellStyles';
import { View, Text } from 'react-native';
import { ServerManager, WoWsNumbers } from '../../../core/';

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
        <WoWsTouchable onPress={this.wows_number}>
          <View style={viewStyle}>
            <Text style={textStyle}>{this.nickname + '|' + this.account_id}</Text> 
          </View>
        </WoWsTouchable>
      </View>
    )
  }

  wows_number = () => {
    let url = WoWsNumbers.getWebsiteUrl(this.nickname, this.account_id);
    Actions.InAppBrowser({title: this.nickname, link: url});  
  }
}

export {SearchResultCell};