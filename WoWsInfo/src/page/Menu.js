import React, { Component } from 'react';
import { View, ScrollView, Text, StyleSheet } from 'react-native';
import { isTablet } from 'react-native-device-detection';
import { List, Colors, Title, Subheading } from 'react-native-paper';
import { HomeButton } from '../component';

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
      <View style={container}>
        <ScrollView showsVerticalScrollIndicator={false}>
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
          <List.Item title='WoWs Official' description='https://www.youtube.com/user/worldofwarshipsCOM'/>
          <List.Item title='Flambass' description='https://www.youtube.com/user/Flambass'/>
          <List.Item title='Notser' description='https://www.youtube.com/user/MrNotser'/>
          <List.Item title='The Mighty Jingles' description='https://www.youtube.com/user/BohemianEagle'/>
          <List.Item title='Panzerknacker' description='https://www.youtube.com/user/pzkpasch'/>
          <List.Item title='Flamu' description='https://www.youtube.com/user/cheesec4t'/>
          <List.Item title='iChaseGaming' description='https://www.youtube.com/user/ichasegaming'/>
          <List.Item title='NoZoupForYou' description='https://www.youtube.com/user/ZoupGaming'/>
        </ScrollView>
        <HomeButton />
      </View>
    )
  };
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    width: isTablet ? '68%' : '100%',
    alignSelf: 'center'
  },
  title: {
    margin: 16
  }
});

export { Menu };
