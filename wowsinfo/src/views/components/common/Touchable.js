/**
 * Touchable.js
 *
 * A basic touchable view
 */

import React, {Component} from 'react';
import {View} from 'react-native';
import {TouchableRipple} from 'react-native-paper';

class Touchable extends Component {
  render() {
    const {style, children, fill, ...props} = this.props;
    return (
      <TouchableRipple {...props} style={fill ? {flex: 1} : null}>
        <View style={style}>{children}</View>
      </TouchableRipple>
    );
  }
}

export {Touchable};
