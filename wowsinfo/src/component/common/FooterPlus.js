/**
 * FooterPlus.js
 *
 * This is a view that connect with WoWs Info footer
 */

import React, {Component} from 'react';
import {View, StyleSheet} from 'react-native';
import {ThemeBackColour} from '../../value/colour';

class FooterPlus extends Component {
  render() {
    const {similarView} = styles;
    const {children, style} = this.props;
    return (
      <View style={[similarView, ThemeBackColour(), style]}>{children}</View>
    );
  }
}

const styles = StyleSheet.create({
  similarView: {
    borderTopLeftRadius: 16,
    borderTopRightRadius: 16,
  },
});

export {FooterPlus};
