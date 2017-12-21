import React from 'react';
import { Basic8Cell, WoWsLoading } from '../../component';
import { View, ScrollView } from 'react-native';

class BasicInfoScreen extends React.PureComponent {
  constructor(props) {
    super();
    this.state = {
      isReady: false,
      data: [],
    }
  }
  render() {
    if (this.state.isReady) {
      return (
        <View>
          <ScrollView>
            <Basic8Cell info={{battle: 9999,winrate: 9999,killdeath: 9999,damage: 9999,hitratio: 9999,survival: 9999,frag: 9999,exp: 9999}}/>
          </ScrollView>
        </View>
      )
    } else return <WoWsLoading />
  }
}

export {BasicInfoScreen};