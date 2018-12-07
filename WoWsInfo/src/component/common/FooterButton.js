import React, { Component } from 'react';
import { SafeAreaView, StyleSheet } from 'react-native';
import { isAndroid } from 'react-native-device-detection';
import { IconButton, Colors } from 'react-native-paper';
import { Actions } from 'react-native-router-flux';
import { SafeAction } from '../../core';

class FooterButton extends Component {
  render() {
    const { icon, left } = this.props;
    // Android has a back button so we dont have to add another one
    // if (isAndroid) return null;
    return (
      <SafeAreaView style={{position: 'absolute', left: left ? 0 : null, right: left ? null : 0}}>
        <IconButton color={Colors.grey500} icon={icon} 
          onPress={() => this.pressEvent()}/>
      </SafeAreaView>
    )
  }

  pressEvent() {
    const { icon } = this.props;
    if (icon === 'setting') SafeAction('Settings');
    else if (icon === 'arrow-back') Actions.pop();
    else if (icon === 'home') Actions.popTo('Menu');
    else SafeAction('Menu');
  }
}

const styles = StyleSheet.create({
  container: {
  },
})

export { FooterButton };