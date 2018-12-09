/**
 * InfoLabel.js
 * 
 * 
 */

import React, { Component } from 'react';
import { View, StyleSheet } from 'react-native';
import { Caption, Text } from 'react-native-paper';

class InfoLabel extends Component {
  render() {
    const { container } = styles;
    const { title, info } = this.props;
    return (
      <View style={container}>
        <Caption>{title}</Caption>
        <Text>{info}</Text>
      </View>
    )
  };
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    alignItems: 'center',
    justifyContent: 'center'
  }
});

export { InfoLabel };
