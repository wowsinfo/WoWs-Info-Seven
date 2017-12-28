import React from 'react';
import { View, Text, Image } from 'react-native';
import { Info3Cell } from './Info3Cell';

class ShipInfoCell extends React.PureComponent {
  render() {
    return (
      <View>
        <View>
          <Image />
          <Text></Text>
        </View>
        <Info3Cell />
      </View>
    )
  }
}

export {ShipInfoCell};