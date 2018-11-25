/**
 * BasicDetail.js
 * 
 * This page displays item details for achievements, consumables, 
 * commander skills and collections
 */

import React, { Component } from 'react';
import { View, Text, StyleSheet } from 'react-native';
import { Surface } from 'react-native-paper';
import { FloatingButton } from '../../component';

class BasicDetail extends Component {
  render() {
    const { container } = styles;
    return (
      <Surface style={container}>
        <FloatingButton />
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

export { BasicDetail };
