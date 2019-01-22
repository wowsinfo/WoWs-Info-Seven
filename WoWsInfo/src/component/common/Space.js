/**
 * Space.js
 * 
 * 
 */

import React, { Component } from 'react';
import { View, StyleSheet } from 'react-native';

class Space extends Component {
  render() {
    const { height } = this.props;

    let h = height;
    if (!height) h = 128;

    return (
      <View style={{height: h}} />
    )
  };
}

const styles = StyleSheet.create({
});

export { Space };
