/**
 * WarshipLabel.js
 *
 * It is a label with ship name, tier and it will be orange if it is a special ship
 */

import React, {Component} from 'react';
import {StyleSheet} from 'react-native';
import {Caption} from 'react-native-paper';
import {getTierLabel} from '../../core';
import {lang} from '../../value/lang';

class WarshipLabel extends Component {
  render() {
    const {label} = styles;
    const {style} = this.props;
    const {item} = this.props;
    if (item) {
      const {tier, name, premium} = item;
      return (
        <Caption
          numberOfLines={1}
          style={[style, label, premium ? {color: 'orange'} : {}]}>
          {`${getTierLabel(tier)} ${name}`}
        </Caption>
      );
    } else {
      return (
        <Caption numberOfLines={1} style={[style, label]}>
          {lang.warship_unkown}
        </Caption>
      );
    }
  }
}

const styles = StyleSheet.create({
  label: {
    textAlign: 'center',
  },
});

export {WarshipLabel};
