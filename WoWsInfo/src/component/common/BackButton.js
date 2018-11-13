import React, { Component } from 'react';
import { View,  StyleSheet } from 'react-native';
import { isIphoneX, isAndroid } from 'react-native-device-detection';
import { IconButton, Colors } from 'react-native-paper';
import { Actions } from 'react-native-router-flux';

class BackButton extends Component {
  render() {
    const { container } = styles;
    // Android has a back button so we dont have to add another one
    if (isAndroid) return null;
    return (
      <View style={container}>
        <IconButton color={Colors.grey500} icon='arrow-back' 
          onPress={() => Actions.pop()}/>
      </View>
    )
  }
}

const styles = StyleSheet.create({
  container: {
    position: 'absolute',
    bottom: isIphoneX ? 8 : 0,
    left: 0
  },
})

export { BackButton };