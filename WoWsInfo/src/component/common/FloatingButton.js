import React, { Component } from 'react';
import { SafeAreaView, StyleSheet } from 'react-native';
import { FAB } from 'react-native-paper';
import { Actions } from 'react-native-router-flux';

class FloatingButton extends Component {
  render() {
    const { container } = styles;
    const { mode } = this.props;
    return (
      <SafeAreaView style={container}>
        { this.renderButton(mode) }
      </SafeAreaView>
    )
  }

  renderButton(mode) {
    return (
      <FAB onPress={() => this.navigate()} mode='contained' 
        icon={mode === 'Home' ? 'home' : 'menu'}>{mode}</FAB>
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
    bottom: 16
  }
})

export { FloatingButton };