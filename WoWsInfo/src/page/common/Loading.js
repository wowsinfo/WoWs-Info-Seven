/**
 * Loading.js
 * 
 * 
 */

import React, { Component } from 'react';
import { View, Image, Text, StyleSheet } from 'react-native';
import { Surface } from 'react-native-paper';
import { ThemeBackColour } from '../../value/colour';

class Loading extends Component {
  render() {
    const { container } = styles;
    console.log(ThemeBackColour());
    return (
      <Surface style={container}>
        <Image source={require('../../img/Logo.png')}/>
        <Text>Loading</Text>
      </Surface>
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

export { Loading };
