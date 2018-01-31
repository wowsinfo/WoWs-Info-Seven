import React from 'react';
import { WoWsTouchable } from '../../component';
import { Image, View, Platform, Alert, Picker, Text } from 'react-native';
import { ServerManager } from '../../core/';

class SwitcherButton extends React.PureComponent {
  render() {
    const { imageStyle, textStyle, data, showImage, label } = this.props;
    if (Platform.OS == 'ios') {
      if (label == null) {
        return (
          <View style={{margin: 8}}>
            <WoWsTouchable onPress={() => this.showAlert()}>
              <Image source={require('../../img/Switcher.png')} style={imageStyle}/>
            </WoWsTouchable>
          </View>
        )
      } else {
        return (
          <View style={{margin: 8}}>
            <WoWsTouchable onPress={this.showAlert()}>
              <View>
                <Text style={textStyle}>{label}</Text>
              </View>
            </WoWsTouchable>
          </View>
        )
      }
    } else {
      return (
        <Picker style={{height: 30, width: 30}} mode='dropdown' selectedValue={global.server} onValueChange={(value, index) => data[index].func}>
          { this.renderPickerItem(data) }
        </Picker>
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
  showAlert() {
    const { data } = this.props;
    // console.log(data);
    var funcList = [];
    for (var i = 0; i < data.length; i++) funcList.push({text: data[i].label, onPress: data[i].func});
    Alert.alert('WoWs Info', '', funcList);
  }
}

export {SwitcherButton};