/**
 * BasicDetail.js
 * 
 * This page displays item details for achievements, consumables, 
 * commander skills and collections
 */

import React, { Component } from 'react';
import { Text, StyleSheet } from 'react-native';
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
    const { container, label } = styles;    
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
          <Title style={label}>{name}</Title>
          <Text style={label}>{price + "\n"}</Text>
          <Paragraph style={label}>{description + "\n"}</Paragraph>
          <Caption style={label}>{bonus}</Caption>
        </Surface>
      )
    } else if (item.perks) {
      // This is commander skill
      const { name, perks } = item;
      let bonus = Object.entries(perks).reduce((total, curr) => {
        return total + curr[1].description + "\n"
      }, "");

      return (
        <Surface style={container}>
          <WikiIcon item={item}/>
          <Title style={label}>{name}</Title>
          <Paragraph style={label}>{bonus}</Paragraph>
        </Surface>
      )
    } else if (item.image_inactive) {
      // This is achievement
      const { description, name } = item;

      return (
        <Surface style={container}>
          <WikiIcon item={item}/>
          <Title style={label}>{name}</Title>
          <Paragraph style={label}>{description}</Paragraph>
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
  label: {
    textAlign: 'center',
    margin: 8
  },
});

export { BasicDetail };
