import React from 'react';
import { WoWsTouchable } from '../../component';
import { Image, View } from 'react-native';

class SwitcherButton extends React.PureComponent {
  render() {
    const { onPress, imageStyle } = this.props;
    return (
      <View style={{margin: 8}}>
        <WoWsTouchable onPress={onPress}>
          <Image source={require('../../img/Switcher.png')} style={imageStyle}/>
        </WoWsTouchable>
      </View>
    )
  }
}

export {SwitcherButton};