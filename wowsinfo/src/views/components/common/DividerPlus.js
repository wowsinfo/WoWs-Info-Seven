import React, {Component} from 'react';
import {StyleSheet} from 'react-native';
import {Divider} from 'react-native-paper';

class DividerPlus extends Component {
  render() {
    const {divider} = styles;
    return <Divider style={divider} />;
  }
}

const styles = StyleSheet.create({
  divider: {
    height: 8,
  },
});

export {DividerPlus};
