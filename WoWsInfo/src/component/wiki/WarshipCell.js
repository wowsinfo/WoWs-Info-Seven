/**
 * WarshipCell.js
 * 
 * It is a cell with a WikiIcon and a WarshipLabel below it
 */

import React, { Component } from 'react';
import { View, Text, StyleSheet } from 'react-native';
import { WikiIcon, WarshipLabel } from '../';

class WarshipCell extends Component {
  render() {
    const { container } = styles;
    const { item } = this.props;
    return (
      <View style={container}>
        <WikiIcon item={item} scale={1.4}/>
        <WarshipLabel style={{marginTop: -16}}item={item}/>
      </View>
    )
  };
}

const styles = StyleSheet.create({
  container: {
    justifyContent: 'center',
    alignItems: 'center'
  }
});

export { WarshipCell };
