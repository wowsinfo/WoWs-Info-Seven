import React, { Component } from 'react';
import { Text } from 'react-native';

class WoWsText extends Component {
  render() {
    const { children, ...props } = this.props;
    return <Text {...props}>{children}</Text>
  }
}

export { WoWsText };