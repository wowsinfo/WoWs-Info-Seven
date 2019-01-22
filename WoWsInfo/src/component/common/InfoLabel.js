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
        { CLEANMODE ? null : <Caption style={{textAlign: 'center', marginBottom: -2}}>{title}</Caption> }
        <Text style={{textAlign: 'center', marginBottom: 2}}>{info}</Text>
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
