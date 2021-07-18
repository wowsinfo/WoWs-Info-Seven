/**
 * TabButton.js
 *
 * It is a styled button tab button
 */

import React, {Component} from 'react';
import {StyleSheet} from 'react-native';
import {IconButton} from 'react-native-paper';
import {Touchable} from '../common/Touchable';

class TabButton extends Component {
  render() {
    const {container} = styles;
    const {label, onPress, disabled, ...props} = this.props;
    return (
      <Touchable fill style={container} onPress={disabled ? null : onPress}>
        <IconButton size={26} disabled={disabled} {...props} />
      </Touchable>
    );
  }
}

const styles = StyleSheet.create({
  container: {
    alignItems: 'center',
    justifyContent: 'center',
    padding: 4,
  },
});

export {TabButton};
