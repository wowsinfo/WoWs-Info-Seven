import React, { Component } from 'react';
import { View, Text, StyleSheet } from 'react-native';
import { isIphoneX } from 'react-native-device-detection';
import { Button } from 'react-native-paper';

class FloatingButton extends Component {
  render() {
    const { container, button } = styles;
    const { mode, icon } = this.props;
    return (
      <View style={container}>
        { this.renderButton(mode) }
      </View>
    )
  }

  renderButton(mode) {
    const { button } = styles;
    return (
      <Button style={button} primary icon={mode === 'Home' ? 'home' : 'menu'} mode='contained' 
        onPress={() => this.navigate()}>
        { mode }
      </Button>
    )
  }

  navigate() {

  }
}

const styles = StyleSheet.create({
  container: {
    position: 'absolute', alignItems: 'center',
    left: 0, right: 0, 
    bottom: isIphoneX ? 16 : 8 
  },
  button: {
    borderRadius: 100,
    width: '38.5%'
  }
})

export { FloatingButton };