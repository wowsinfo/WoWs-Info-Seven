import React, { Component } from 'react';
import { SafeAreaView, StyleSheet } from 'react-native';
import { FAB } from 'react-native-paper';
import { Actions } from 'react-native-router-flux';

class FloatingButton extends Component {
  render() {
    const { container } = styles;
    return (
      <SafeAreaView style={container}>
        <FAB onPress={() => this.navigate()} mode='contained' icon={'menu'} />
      </SafeAreaView>
    )
  }

  navigate() {
    if (Actions.state.routes.findIndex(r => r.routeName === 'Menu') > 0) {
      // Pop to menu 
      Actions.popTo('Menu');
    } else if (Actions.currentScene !== 'Menu') {
      // Add guard so that it wont push twice]
      Actions.Menu();
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