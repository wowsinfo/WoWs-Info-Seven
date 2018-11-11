import React, { Component } from 'react';
import { View, ScrollView, Text, StyleSheet } from 'react-native';
import { isTablet } from 'react-native-device-detection';
import { List, Colors, Title, Subheading, Divider, Surface } from 'react-native-paper';
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
      <Surface style={container}>
        <ScrollView showsVerticalScrollIndicator={false} contentContainerStyle={{paddingBottom: 32}}>
          <List.Section title='Encyclopedia'>
            <List.Item title='Achievements' 
              left={() => <List.Icon color={Colors.blue300} icon={require('../img/Achievement.png')}/>}/>
            <List.Item title='Warships'
              left={() => <List.Icon color={Colors.blue300} icon={require('../img/Warship.png')}/>}/>
            <List.Item title='Upgrades'
              left={() => <List.Icon color={Colors.blue300} icon={require('../img/Upgrade.png')}/>}/>
            <List.Item title='Flag/Camouflage'
              left={() => <List.Icon color={Colors.blue300} icon={require('../img/Camouflage.png')}/>}/>
            <List.Item title='Commander Skills'
              left={() => <List.Icon color={Colors.blue300} icon={require('../img/CommanderSkill.png')}/>}/>
            <List.Item title='Maps'
              left={() => <List.Icon color={Colors.blue300} icon='map'/>}/>
            <List.Item title='Collections'
              left={() => <List.Icon color={Colors.blue300} icon={require('../img/Collection.png')}/>}/>
          </List.Section>
          <Divider />
          <List.Section title='Extra'>
            <List.Accordion title='Websites'>
              <List.Item title='World of Warships' description='https://worldofwarships.com/'/>
              <List.Item title='Premium Shop' description='https://asia.wargaming.net/shop/wows/'/>
              <List.Item title='Global Wiki' description='http://wiki.wargaming.net/en/World_of_Warships/'/>
              <List.Item title='Sea Group' description='https://sea-group.org/'/>
              <List.Item title='The Daily Bounce' description='https://thedailybounce.net/category/world-of-warships/'/>
              <List.Item title='WoWS Stats & Numbers' description='https://wows-numbers.com/'/>
              <List.Item title='Warships.Today' description='https://warships.today/'/>
              <List.Item title='Player Ranking' description='http://maplesyrup.sweet.coocan.jp/wows/ranking/'/>
              <List.Item title='Warships Models' description='https://sketchfab.com/tags/world-of-warships'/>
            </List.Accordion>
            <List.Accordion title='Youtubers'>
              <List.Item title='WoWs Official' description='https://www.youtube.com/user/worldofwarshipsCOM'/>
              <List.Item title='Flambass' description='https://www.youtube.com/user/Flambass'/>
              <List.Item title='Notser' description='https://www.youtube.com/user/MrNotser'/>
              <List.Item title='The Mighty Jingles' description='https://www.youtube.com/user/BohemianEagle'/>
              <List.Item title='Panzerknacker' description='https://www.youtube.com/user/pzkpasch'/>
              <List.Item title='Flamu' description='https://www.youtube.com/user/cheesec4t'/>
              <List.Item title='iChaseGaming' description='https://www.youtube.com/user/ichasegaming'/>
              <List.Item title='NoZoupForYou' description='https://www.youtube.com/user/ZoupGaming'/>
            </List.Accordion>
          </List.Section>
        </ScrollView>
        <HomeButton />
      </Surface>
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
