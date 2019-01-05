/**
 * BasicDetail.js
 * 
 * This page displays item details for achievements, consumables, 
 * commander skills and collections
 */

import React, { Component } from 'react';
import { Text, ScrollView, StyleSheet } from 'react-native';
import { Surface, Title, Paragraph, Caption } from 'react-native-paper';
import { FloatingButton, WikiIcon, WoWsInfo, PriceLabel } from '../../component';

class BasicDetail extends Component {
  render() {
    const { item } = this.props;
    console.log(item);

    let ID = '';
    if (item.consumable_id) ID = item.consumable_id;
    else if (item.achievement_id) ID = item.achievement_id;
    else if (item.collection_id) ID = item.card_id;

    return (
      <WoWsInfo title={ID}>
        { this.renderDetail() }
      </WoWsInfo>
    )
  };

  renderDetail() {
    const { item } = this.props;
    const { container, label } = styles;    

    if (item.profile) {
      // Consumables
      const { name, description, profile } = item;
      let bonus = Object.entries(profile).reduce((total, curr) => {
        return total + curr[1].description + '\n';
      }, "");

      return (
        <ScrollView contentContainerStyle={container}>
          <WikiIcon scale={1.6} item={item}/>
          <Title style={label}>{name}</Title>
          <PriceLabel item={item}/>
          <Paragraph style={label}>{description}</Paragraph>
          <Caption style={label}>{bonus}</Caption>
        </ScrollView>
      )
    } else if (item.perks) {
      // This is commander skill
      const { name, perks } = item;
      let bonus = Object.entries(perks).reduce((total, curr) => {
        return total + curr[1].description + '\n';
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
