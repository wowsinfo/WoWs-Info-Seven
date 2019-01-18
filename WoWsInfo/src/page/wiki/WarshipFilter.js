/**
 * WarshipFilter.js
 * 
 * 
 */

import React, { Component } from 'react';
import { View, StyleSheet } from 'react-native';
import { Surface, Text } from 'react-native-paper';
import { WoWsInfo } from '../../component';

class WarshipFilter extends Component {
  render() {
    const { container } = styles;
    return (
      <WoWsInfo>
        <Text>WarshipFilter</Text>
      </WoWsInfo>
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

export { WarshipFilter };
