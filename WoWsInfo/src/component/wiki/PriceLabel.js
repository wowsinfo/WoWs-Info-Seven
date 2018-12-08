/**
 * PriceLabel.js
 * 
 * 
 */

import React, { Component } from 'react';
import { StyleSheet } from 'react-native';
import { Text } from 'react-native-paper';

class PriceLabel extends Component {
  render() {
    const { container } = styles;
    const { item } = this.props;

    let price = item.price_gold;
    let colour = 'orange';
    if (item.price_gold === 0) {
      price = item.price_credit;
      colour = 'grey';
    }

    return (
      <Text style={{color: colour, textAlign: 'center'}}>{price}</Text>
    )
  };
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    alignItems: 'center',
    justifyContent: 'center'
  }
});

export { PriceLabel };
