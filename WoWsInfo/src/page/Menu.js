import React, { Component } from 'react';
import { View, ScrollView, Text, StyleSheet } from 'react-native';
import { List, Colors, Title, Subheading } from 'react-native-paper';

class Menu extends Component {
  state = {
    expanded: true
  }

  _handlePress = () =>
  this.setState({
    expanded: !this.state.expanded
  });

  render() {
    const { container, title } = styles;
    return (
      <ScrollView style={container}>
        <Title style={title}>Encyclopedia</Title>
        <List.Item title='Achievements'/>
        <List.Item title='Warships'/>
        <List.Item title='Upgrades'/>
        <List.Item title='Flag/Camouflage'/>
        <List.Item title='Commander Skills'/>
        <List.Item title='Maps'/>
        <List.Item title='Collections'/>
        <Title style={title}>Websites</Title>
        <List.Item title='World of Warships' description='https://worldofwarships.com/'/>
        <List.Item title='Premium Shop' description='https://asia.wargaming.net/shop/wows/'/>
        <List.Item title='Global Wiki' description='http://wiki.wargaming.net/en/World_of_Warships/'/>
        <List.Item title='Sea Group' description='https://sea-group.org/'/>
        <List.Item title='The Daily Bounce' description='https://thedailybounce.net/category/world-of-warships/'/>
        <List.Item title='WoWS Stats & Numbers' description='https://wows-numbers.com/'/>
        <List.Item title='Warships.Today' description='https://warships.today/'/>
        <List.Item title='Player Ranking' description='http://maplesyrup.sweet.coocan.jp/wows/ranking/'/>
        <List.Item title='Warships Models' description='https://sketchfab.com/tags/world-of-warships'/>
        <Title style={title}>Youtubers</Title>
      </ScrollView>
    )
  };
}

const styles = StyleSheet.create({
  container: {
    flex: 1
  },
  title: {
    margin: 16
  }
});

export { Menu };
