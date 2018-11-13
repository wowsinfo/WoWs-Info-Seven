import React, { Component } from 'react';
import { View,  StyleSheet } from 'react-native';
import { isIphoneX } from 'react-native-device-detection';
import { List } from 'react-native-paper';

class BackButton extends Component {
  render() {
    const { container } = styles;
    return (
      <View style={container}>
        <List.Icon style={{padding: 4}} icon='arrow-back' />
      </View>
    )
  }
}

const styles = StyleSheet.create({
  container: {
    position: 'absolute',
    bottom: isIphoneX ? 6 : 0,
    left: 0
  },
})

export { BackButton };