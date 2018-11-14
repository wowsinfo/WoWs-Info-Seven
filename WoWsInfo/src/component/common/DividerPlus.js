import React, { Component } from 'react';
import { SafeAreaView, Text, StyleSheet } from 'react-native';
import { Button, Divider } from 'react-native-paper';
import { isAndroid } from 'react-native-device-detection';
import lang from '../../value/lang';

class DividerPlus extends Component {
  render() {
    const { divider } = styles;
    return <Divider style={divider}/>;
  };
}

const styles = StyleSheet.create({
  divider: {
    height: 8
  }
});

export { DividerPlus };
