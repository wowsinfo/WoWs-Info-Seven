import React, { Component } from 'react';
import { TouchableNativeFeedback, TouchableOpacity, View } from 'react-native';

class WoWsTouchable extends Component {
  render() {
    const { children, style, ...props  } = this.props;
    const Touchable = android ? TouchableNativeFeedback : TouchableOpacity;    
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