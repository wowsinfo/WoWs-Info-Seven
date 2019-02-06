import React, { Component } from 'react';
import { SafeAreaView, StyleSheet } from 'react-native';
import { isAndroid } from 'react-native-device-detection';
import { IconButton, Colors } from 'react-native-paper';
import { Actions } from 'react-native-router-flux';
import { SafeAction } from '../../core';
import lang from '../../value/lang';

class FooterButton extends Component {
  render() {
    const { icon, left } = this.props;

    let al = '';
    if (icon === 'settings') al = lang.button_settings_label;
    else if (icon === 'arrow-back') al = lang.button_back_label;
    else if (icon === 'home') al = lang.button_home_label;
    else al = lang.button_menu_label;

    return (
      <SafeAreaView style={{position: 'absolute', left: left ? 0 : null, right: left ? null : 0}}>
        <IconButton color={Colors.grey500} icon={icon} accessibilityLabel={al}
          onPress={() => this.pressEvent()}/>
      </SafeAreaView>
    )
  }

  pressEvent() {
    const { icon } = this.props;
    if (icon === 'settings') SafeAction('Settings');
    else if (icon === 'arrow-back') Actions.pop();
    else if (icon === 'home') {
      // Go back when home is not found
      if (Actions.state.routes.findIndex(r => r.routeName === 'Menu') > -1) {
        Actions.popTo('Menu');
      } else {
        Actions.pop();
      }
    } else SafeAction('Menu');
  }
}

const styles = StyleSheet.create({
  container: {
  },
})

export { FooterButton };