import React, { Component } from 'react';
import { SafeAreaView } from 'react-native';
import { IconButton, Colors } from 'react-native-paper';
import { Actions } from 'react-native-router-flux';
import { SafeAction } from '../../core';
import { lang } from '../../value/lang';

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
    else if (icon === 'arrow-back') {
      Actions.pop();
      if (Actions.state.routes.length === 2) {
        setTimeout(() => Actions.refresh(), 1000);
      }
    } else if (icon === 'home') {
      Actions.popTo('Menu');
      setTimeout(() => Actions.refresh(), 1000);
    } else SafeAction('Search');
  }
}

export { FooterButton };