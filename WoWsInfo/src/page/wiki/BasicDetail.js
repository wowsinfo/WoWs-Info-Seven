/**
 * BasicDetail.js
 * 
 * This page displays item details for achievements, consumables, 
 * commander skills and collections
 */

import React, { Component } from 'react';
import { Text, ScrollView, StyleSheet } from 'react-native';
import { Surface, Title, Paragraph, Caption } from 'react-native-paper';
import { FloatingButton, WikiIcon, WoWsInfo } from '../../component';

class BasicDetail extends Component {
  render() {
    return (
      <WoWsInfo>
        { this.renderDetail() }
      </WoWsInfo>
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
      let priceColour = price_credit == 0 ? 'orange' : 'grey'; 
      let bonus = Object.entries(profile).reduce((total, curr) => {
        return total + curr[1].description;
      }, "");

      return (
        <ScrollView contentContainerStyle={container}>
          <WikiIcon scale={1.6} item={item}/>
          <Title style={label}>{name}</Title>
          <Text style={[label, {color: priceColour}]}>{price}</Text>
          <Paragraph style={label}>{description}</Paragraph>
          <Caption style={label}>{bonus}</Caption>
        </ScrollView>
      )
    } else if (item.perks) {
      // This is commander skill
      const { name, perks } = item;
      let bonus = Object.entries(perks).reduce((total, curr) => {
        return total + curr[1].description;
      }, "");

      return (
        <ScrollView contentContainerStyle={container}>
          <WikiIcon scale={1.6} item={item}/>
          <Title style={label}>{name}</Title>
          <Paragraph style={label}>{bonus}</Paragraph>
        </ScrollView>
      )
    } else if (item.image_inactive || item.card_id) {
      // This is achievement or collection item
      const { description, name } = item;

      return (
        <ScrollView contentContainerStyle={container}>
          <WikiIcon scale={1.6} item={item}/>
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
    margin: 8,
    marginTop: 8
  },
});

export { BasicDetail };
