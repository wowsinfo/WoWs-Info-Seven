import React, { Component } from 'react';
import { SafeAreaView, StyleSheet } from 'react-native';
import { isAndroid } from 'react-native-device-detection';
import { IconButton, Colors } from 'react-native-paper';
import { Actions } from 'react-native-router-flux';

class BackButton extends Component {
  render() {
    const { container } = styles;
    // Android has a back button so we dont have to add another one
    // if (isAndroid) return null;
    return (
      <SafeAreaView style={container}>
        <IconButton color={Colors.grey500} icon='arrow-back' 
          onPress={() => Actions.pop()}/>
      </SafeAreaView>
    )
  }
}

const styles = StyleSheet.create({
  container: {
    position: 'absolute',
    right: 0
  },
})

export { BackButton };