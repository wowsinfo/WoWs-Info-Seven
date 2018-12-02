/**
 * BasicDetail.js
 * 
 * This page displays item details for achievements, consumables, 
 * commander skills and collections
 */

import React, { Component } from 'react';
import { Text, ScrollView, StyleSheet } from 'react-native';
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
        <ScrollView contentContainerStyle={container}>
          <WikiIcon item={item}/>
          <Title style={label}>{name}</Title>
          <Text style={label}>{price + "\n"}</Text>
          <Paragraph style={label}>{description + "\n"}</Paragraph>
          <Caption style={label}>{bonus}</Caption>
        </ScrollView>
      )
    } else if (item.perks) {
      // This is commander skill
      const { name, perks } = item;
      let bonus = Object.entries(perks).reduce((total, curr) => {
        return total + curr[1].description + "\n"
      }, "");

      return (
        <ScrollView contentContainerStyle={container}>
          <WikiIcon item={item}/>
          <Title style={label}>{name}</Title>
          <Paragraph style={label}>{bonus}</Paragraph>
        </ScrollView>
      )
    } else if (item.image_inactive || item.card_id) {
      // This is achievement or collection item
      const { description, name } = item;

      return (
        <ScrollView contentContainerStyle={container}>
          <WikiIcon item={item}/>
          <Title style={label}>{name}</Title>
          <Paragraph style={label}>{description}</Paragraph>
        </ScrollView>
      )
    }
  }
}

const styles = StyleSheet.create({
  container: {
    height: '100%',
    alignItems: 'center',
    justifyContent: 'center'
  },
  label: {
    textAlign: 'center',
    margin: 8
  },
});

export { BasicDetail };
