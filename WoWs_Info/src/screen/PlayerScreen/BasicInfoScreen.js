import React from 'react';
import { Basic8Cell, WoWsLoading } from '../../component';
import { View, ScrollView, Text } from 'react-native';
import { Divider } from 'react-native-elements';
import { WoWsTouchable } from '../../component';
import { styles } from './BasicInfoScreenStyles';

class BasicInfoScreen extends React.PureComponent {
  constructor(props) {
    super();
    this.state = {
      isReady: true,
      data: [],
    }
  }

  render() {
    if (this.state.isReady) {
      const { id, playerName } = this.props;
      const { playerNameStyle, scrollViewStyle, mainViewStyle, playerInfoStyle, playerViewStyle, setasmainTextStyle, setasmainViewStyle } = styles;
      console.log(this.props);
      return (
        <View style={mainViewStyle}>
          <ScrollView containerStyle={scrollViewStyle}>
            <View style={[playerViewStyle, {backgroundColor: global.themeColour}]}>
              <Text style={playerNameStyle}>{playerName}</Text>
              <WoWsTouchable>
                <View style={setasmainViewStyle}>
                  <Text style={setasmainTextStyle}>Set as Main</Text>
                </View>
              </WoWsTouchable>             
              <Text style={playerInfoStyle}>600 Days | Lv 15 | ⭐️15</Text>
            </View>
            <Basic8Cell info={{battle: 9999,winrate: 9999,killdeath: 9999,damage: 9999,hitratio: 9999,survival: 9999,frag: 9999,exp: 9999}}/>
            <Divider style={{height: 1.5, backgroundColor: global.themeColour}}/>
          </ScrollView>
        </View>
      )
    } else return <WoWsLoading />
  }
}

export {BasicInfoScreen};