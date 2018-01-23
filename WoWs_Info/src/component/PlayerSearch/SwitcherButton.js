import React from 'react';
import { WoWsTouchable } from '../../component';
import { Image, View, Platform, Alert } from 'react-native';
import strings from '../../localization';
import { ServerManager } from '../../core/';

class SwitcherButton extends React.PureComponent {
  render() {
    const { onPress, imageStyle } = this.props;
    if (Platform.OS == 'ios') {
      return (
        <View style={{margin: 8}}>
          <WoWsTouchable onPress={this.showAlert}>
            <Image source={require('../../img/Switcher.png')} style={imageStyle}/>
          </WoWsTouchable>
        </View>
      )
    } else {

    }
  }

  showAlert = () => {
    const { data } = this.props;
    console.log(data);
    var funcList = [];
    for (var i = 0; i < data.length; i++) funcList.push({text: data[i].label, onPress: data[i].func});
    Alert.alert(strings.change_server, strings.curr_server + ServerManager.getCurrName(global.server), funcList);
  }
}

export {SwitcherButton};