import React, { Component } from 'react';
import { SafeAreaView, ScrollView, StyleSheet, Linking } from 'react-native';
import { isTablet } from 'react-native-device-detection';
import GridView from 'react-native-super-grid';
import { List, Colors, Surface } from 'react-native-paper';
import { FloatingButton } from '../component';
import lang from '../value/lang';

class Menu extends Component {
  state = {
    expanded: true
  }

  _handlePress = () =>
  this.setState({
    expanded: !this.state.expanded
  });

  render() {
    const { container, icon } = styles;

    // Data for the list
    const wiki = [{t: lang.wiki_achievement, i: require('../img/Achievement.png')},
                  {t: lang.wiki_warships, i: require('../img/Warship.png')},
                  {t: lang.wiki_upgrades, i: require('../img/Upgrade.png')},
                  {t: lang.wiki_flags, i: require('../img/Camouflage.png')},
                  {t: lang.wiki_skills, i: require('../img/CommanderSkill.png')},
                  {t: lang.wiki_maps, i: 'map'},
                  {t: lang.wiki_collections, i: require('../img/Collection.png')}];
    // TODO: change links base on player server
    const websites = [{t: lang.website_official_site, d: 'https://worldofwarships.com/'},
                      {t: lang.website_premium, d: 'https://asia.wargaming.net/shop/wows/'},
                      {t: lang.website_global_wiki, d: 'http://wiki.wargaming.net/en/World_of_Warships/'},
                      {t: lang.website_sea_group, d: 'https://sea-group.org/'},
                      {t: lang.website_daily_bounce, d: 'https://thedailybounce.net/category/world-of-warships/'},
                      {t: lang.website_numbers, d: 'https://wows-numbers.com/'},
                      {t: lang.website_today, d: 'https://warships.today/'},
                      {t: lang.website_ranking, d: 'http://maplesyrup.sweet.coocan.jp/wows/ranking/'},
                      {t: lang.website_models, d: 'https://sketchfab.com/tags/world-of-warships'}];
    const youtubers = [{t: lang.youtuber_official, d: 'https://www.youtube.com/user/worldofwarshipsCOM'},
                       {t: lang.youtuber_flambass, d: 'https://www.youtube.com/user/Flambass'},
                       {t: lang.youtuber_notser, d: 'https://www.youtube.com/user/MrNotser'},
                       {t: lang.youtuber_jingles, d: 'https://www.youtube.com/user/BohemianEagle'},
                       {t: lang.youtuber_panzerknacker, d: 'https://www.youtube.com/user/pzkpasch'},
                       {t: lang.youtuber_flamu, d: 'https://www.youtube.com/user/cheesec4t'},
                       {t: lang.youtuber_yuro, d: 'https://www.youtube.com/user/spzjess'},
                       {t: lang.youtuber_iChaseGaming, d: 'https://www.youtube.com/user/ichasegaming'},
                       {t: lang.youtuber_NoZoupForYou, d: 'https://www.youtube.com/user/ZoupGaming'}];

    return (
      <Surface style={container}>
        <SafeAreaView style={{flex: 1}}>
          <ScrollView showsVerticalScrollIndicator={false} 
            contentContainerStyle={{paddingBottom: 32}}>
            <List.Section title={lang.wiki_section_title}>
              <GridView itemDimension={280} items={wiki} spacing={0}
                renderItem={item => (
                  <List.Item title={item.t}
                    left={() => <List.Icon style={icon} color={Colors.blue300} icon={item.i}/>}/>
                )}/>
            </List.Section>
            <List.Section title={lang.extra_section_title}>
              <List.Accordion title={lang.website_title}>
                <GridView itemDimension={280} items={websites} spacing={0}
                  renderItem={item => (
                    <List.Item title={item.t} description={item.d}
                      onPress={() => Linking.openURL(item.d)}/>
                  )}/>
              </List.Accordion>
              <List.Accordion title={lang.youtuber_title}>
                <GridView itemDimension={280} items={youtubers} spacing={0}
                  renderItem={item => (
                    <List.Item title={item.t} description={item.d}
                      onPress={() => Linking.openURL(item.d)}/>
                  )}/>
              </List.Accordion>
            </List.Section>
          </ScrollView>
        </SafeAreaView>
        <FloatingButton mode='Home'/>
      </Surface>
    )
  };
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    width: isTablet ? '61%' : '100%',
    alignSelf: 'center'
  },
  icon: {
    backgroundColor: Colors.blueGrey50, 
    borderRadius: 100
  }
});

export { Menu };
