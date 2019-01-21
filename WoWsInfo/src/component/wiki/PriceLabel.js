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
    const { price_credit, price_gold } = item;

    let price = price_gold;
    let colour = 'orange';
    if (!price_gold || price_gold === 0) {
      price = item.price_credit;
      colour = 'grey';
    }
    console.log(item);

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
