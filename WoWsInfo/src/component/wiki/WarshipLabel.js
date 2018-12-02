/**
 * WarshipLabel.js
 * 
 * It is a label with ship name, tier and it will be orange if it is a special ship
 */

import React, { Component } from 'react';
import { View, StyleSheet } from 'react-native';
import { Caption } from 'react-native-paper';
import { getTierLabel } from '../../core';

class WarshipLabel extends Component {
  render() {
    const { label } = styles;
    const { style } = this.props;
    const { tier, name, premium } = this.props.item;

    return (
      <Caption numberOfLines={1} style={[style, label, {color: premium ? 'orange' : null}]}>
        {`${getTierLabel(tier)} ${name}`}
      </Caption>
    )
  };
}

const styles = StyleSheet.create({
  label: {
    textAlign: 'center',
  }
});

export { WarshipLabel };
