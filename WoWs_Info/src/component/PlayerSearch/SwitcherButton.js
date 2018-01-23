import React from 'react';
import { WoWsTouchable } from '../../component';
import { Image, View, Platform, Alert, Picker } from 'react-native';
import strings from '../../localization';
import { ServerManager } from '../../core/';

class SwitcherButton extends React.PureComponent {
  render() {
    const { imageStyle, data } = this.props;
    if (Platform.OS == 'ios') {
      return (
        <View style={{margin: 8}}>
          <WoWsTouchable onPress={this.showAlert}>
            <Image source={require('../../img/Switcher.png')} style={imageStyle}/>
          </WoWsTouchable>
        </View>
      )
    } else {
      return (
        <View style={{margin: 8}}>
          <Picker style={{height: 30, width: 30}} selectedValue={global.server} onValueChange={(value, index) => data[value].func()}>
            { this.renderPickerItem(data) }
          </Picker>
        </View>
      )
    }
  }

  // Android
  renderPickerItem(data) {
    return data.map((data, i) => {
      return (
        <Picker.Item key={i} label={data.label} value={i}/>
      )
    })
  }

  // IOS
  showAlert = () => {
    const { data } = this.props;
    // console.log(data);
    var funcList = [];
    for (var i = 0; i < data.length; i++) funcList.push({text: data[i].label, onPress: data[i].func});
    Alert.alert(strings.change_server, strings.curr_server + ServerManager.getCurrName(global.server), funcList);
  }
}

export {SwitcherButton};