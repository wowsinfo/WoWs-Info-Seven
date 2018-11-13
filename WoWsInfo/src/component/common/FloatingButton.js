import React, { Component } from 'react';
import { View, Text, StyleSheet } from 'react-native';
import { isIphoneX } from 'react-native-device-detection';
import { Button } from 'react-native-paper';
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
      <Button style={button} primary icon={curr === 'Home' ? 'home' : 'menu'} mode='contained' 
        onPress={() => this.navigate()}>
        { curr }
      </Button>
    )
  }

  navigate() {
    const { mode } = this.props;
    if (mode === 'Menu') {
      Actions.Menu();
    } else {
      Actions.popTo('Home');
    }
  }
}

const styles = StyleSheet.create({
  container: {
    position: 'absolute', alignItems: 'center',
    left: 0, right: 0, 
    bottom: isIphoneX ? 14 : 8 
  },
  button: {
    borderRadius: 100,
    width: '38.5%'
  }
})

export { FloatingButton };