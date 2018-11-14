import React, { Component } from 'react';
import { View, Text, StyleSheet } from 'react-native';
import { isIphoneX } from 'react-native-device-detection';
import { Button, FAB } from 'react-native-paper';
import { Actions } from 'react-native-router-flux';

class FloatingButton extends Component {
  render() {
    const { container } = styles;
    const { mode } = this.props;
    return (
      <View style={container}>
        { this.renderButton(mode) }
      </View>
    )
  }

  renderButton(mode) {
    const { button } = styles;
    const curr = this.props.mode;
    return (
      <FAB style={button} icon={curr === 'Home' ? 'home' : 'menu'} mode='contained' 
        onPress={() => this.navigate()}>
        { curr }
      </FAB>
    )
  }

  navigate() {
    const { mode } = this.props;
    if (mode === 'Menu') {
      // Add guard so that it wont push twice
      Actions.currentScene !== 'Menu' && Actions.Menu();
    } else {
      Actions.popTo('Home');
    }
  }
}

const styles = StyleSheet.create({
  container: {
    position: 'absolute',
    right: 16, 
    bottom: isIphoneX ? 24 : 16 
  },
  button: {
    height: 64, width: 64,
    borderRadius: 32,
    alignItems: 'center',
    justifyContent: 'center'
  }
})

export { FloatingButton };