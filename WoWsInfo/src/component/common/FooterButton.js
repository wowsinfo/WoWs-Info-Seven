import React, { Component } from 'react';
import { Button, Colors, TouchableRipple } from 'react-native-paper';
import { Actions } from 'react-native-router-flux';
import { SafeAction } from '../../core';
import { setLastLocation } from '../../value/data';

class FooterButton extends Component {
  render() {
    const { icon, left } = this.props;

    return (
      <TouchableRipple onPress={() => this.pressEvent()} style={{zIndex: 9999, position: 'absolute', left: left ? 0 : null, right: left ? null : 0}} >
        <Button color={Colors.grey500} icon={icon} compact/>
      </TouchableRipple>
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
      // Clear last location
      setLastLocation('');
      setTimeout(() => Actions.refresh(), 1000);
    } else SafeAction('Search');
  }
}

export { FooterButton };