/**
 * BasicDetail.js
 * 
 * This page displays item details for achievements, consumables, 
 * commander skills and collections
 */

import React, { Component } from 'react';
import { SafeAreaView, Text, StyleSheet } from 'react-native';
import { Surface, Title, Paragraph, Caption } from 'react-native-paper';
import { FloatingButton, WikiIcon, SafeView } from '../../component';

class BasicDetail extends Component {
  render() {
    return (
      <SafeView>
        { this.renderDetail() }
        <FloatingButton />
      </SafeView>
    )
  };

  renderDetail() {
    const { item } = this.props;
    const { container } = styles;    
    console.log(item);
    if (item.profile) {
      // Consumables
      const { name, description, price_credit, price_gold, profile } = item;
      let price = price_gold == 0 ? price_credit : price_gold;
      let bonus = Object.entries(profile).reduce((total, curr) => {
        return total + curr[1].description + "\n"
      }, "");

      return (
        <Surface style={container}>
          <WikiIcon item={item}/>
          <Title style={styles.name}>{name}</Title>
          <Text style={styles.price}>{price + "\n"}</Text>
          <Paragraph style={styles.name}>{description + "\n"}</Paragraph>
          <Caption style={styles.bonus}>{bonus}</Caption>
        </Surface>
      )
    }
  }
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    alignItems: 'center',
    justifyContent: 'center'
  },
  name: {
    textAlign: 'center',
  },
  price: {
    textAlign: 'center',
  },
  bonus: {
    textAlign: 'center',
  }
});

export { BasicDetail };
