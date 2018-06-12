import React, { Component } from 'react';
import { TouchableNativeFeedback, TouchableBounce, Platform, View } from 'react-native';

class WoWsTouchable extends Component {
  render() {
    const { children, style, ...props  } = this.props;
    const Touchable = (Platform.OS == 'android') ? TouchableNativeFeedback : TouchableBounce;    
    return (
      <Touchable {...props}>
        <View style={style}>
          {children}
        </View>
      </Touchable>
    )
  }
}

export { WoWsTouchable };