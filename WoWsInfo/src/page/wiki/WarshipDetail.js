/**
 * WarshipDetail.js
 * 
 * 
 */

import React, { Component } from 'react';
import { View, Text, StyleSheet } from 'react-native';
import { WoWsInfo } from '../../component';

class WarshipDetail extends Component {
  render() {
    const { container } = styles;
    return (
      <WoWsInfo>
        
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

export { WarshipDetail };
