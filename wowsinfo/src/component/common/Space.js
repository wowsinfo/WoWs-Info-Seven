/**
 * Space.js
 *
 * Add space to component
 */

import React, {Component} from 'react';
import {View, StyleSheet} from 'react-native';
import {SafeValue} from '../../core';

class Space extends Component {
  render() {
    const {height} = this.props;

    // Default value is 128
    let h = SafeValue(height, 128);

    return <View style={{height: h}} />;
  }
}

const styles = StyleSheet.create({});

export {Space};
