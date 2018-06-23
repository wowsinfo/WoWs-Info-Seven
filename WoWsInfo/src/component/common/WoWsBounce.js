import React, { Component } from 'react';
import { View } from 'react-native';

var TouchableBounce = require('TouchableBounce');
class WoWsBounce extends Component {
  render() {
    const { children, style, ...props  } = this.props;   
    return (
      <TouchableBounce {...props}>
        <View style={style}>
          {children}
        </View>
      </TouchableBounce>
    )
  }
}

export { WoWsBounce };