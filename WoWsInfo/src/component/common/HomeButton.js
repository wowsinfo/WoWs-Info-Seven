import React, { Component } from 'react';
import { View, Text, StyleSheet } from 'react-native';
import { Button } from 'react-native-paper';

class HomeButton extends Component {
  render() {
    const { container, button } = styles;
    return (
      <View style={container}>
        <Button style={button} primary icon='home' mode='contained' 
          onPress={() => console.log('Pressed')} accessibilityLabel='Go back to Home'>
          Home
        </Button>
      </View>
    )
  }
}

const styles = StyleSheet.create({
  container: {
    position: 'absolute',
    bottom: 8, right: 0,
  },
  button: {
    borderTopLeftRadius: 100,
    borderBottomLeftRadius: 100
  }
})

export { HomeButton };