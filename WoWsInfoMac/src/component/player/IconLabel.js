/**
 * IconLabel.js
 * 
 * A label with an icon on top
 */

import React, { Component } from 'react';
import { View, StyleSheet } from 'react-native';
import { IconButton, Text } from 'react-native-paper';
import { TintColour } from '../../value/colour';

class IconLabel extends Component {
  render() {
    const { container, label } = styles;
    const { info, ...props } = this.props;
    return (
      <View style={container}>
        <IconButton size={36} color={TintColour()[500]} {...props}/>
        <Text style={label}>{info}</Text>
      </View>
    )
  };
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    alignItems: 'center',
    justifyContent: 'center',
    padding: 4
  },
  label: {
    fontSize: 14,
  }
});

export { IconLabel };
