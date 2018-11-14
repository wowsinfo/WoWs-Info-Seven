/**
 * Menu.js
 * 
 * Menu shows wiki and extra
 * It also has the ability to search players and clans
 */

import React, { Component } from 'react';
import { SafeAreaView, ScrollView, StyleSheet, Linking } from 'react-native';
import { isAndroid, isIphoneX } from 'react-native-device-detection';
import { List, Colors, Surface, Searchbar } from 'react-native-paper';
import { BackButton, WoWsInfo } from '../component';
import lang from '../value/lang';

class Menu extends Component {

  constructor(props) {
    super(props);

    this.state = {
      search: ''
    }

    // Data for the list
    this.wiki = [{t: lang.wiki_achievement, i: require('../img/Achievement.png')},
    {t: lang.wiki_warships, i: require('../img/Warship.png')},
    {t: lang.wiki_upgrades, i: require('../img/Upgrade.png')},
    {t: lang.wiki_flags, i: require('../img/Camouflage.png')},
    {t: lang.wiki_skills, i: require('../img/CommanderSkill.png')},
    {t: lang.wiki_maps, i: 'map'},
    {t: lang.wiki_collections, i: require('../img/Collection.png')}];
    // TODO: change links base on player server
    this.websites = [{t: lang.website_official_site, d: 'https://worldofwarships.com/'},
    {t: lang.website_premium, d: 'https://asia.wargaming.net/shop/wows/'},
    {t: lang.website_global_wiki, d: 'http://wiki.wargaming.net/en/World_of_Warships/'},
    {t: lang.website_dev_blog, d: 'https://www.facebook.com/wowsdevblog/'},
    {t: lang.website_sea_group, d: 'https://sea-group.org/'},
    {t: lang.website_daily_bounce, d: 'https://thedailybounce.net/category/world-of-warships/'},
    {t: lang.website_numbers, d: 'https://wows-numbers.com/'},
    {t: lang.website_today, d: 'https://warships.today/'},
    {t: lang.website_ranking, d: 'http://maplesyrup.sweet.coocan.jp/wows/ranking/'},
    {t: lang.website_models, d: 'https://sketchfab.com/tags/world-of-warships'}];
    this.youtubers = [{t: lang.youtuber_official, d: 'https://www.youtube.com/user/worldofwarshipsCOM'},
    {t: lang.youtuber_flambass, d: 'https://www.youtube.com/user/Flambass'},
    {t: lang.youtuber_notser, d: 'https://www.youtube.com/user/MrNotser'},
    {t: lang.youtuber_jingles, d: 'https://www.youtube.com/user/BohemianEagle'},
    {t: lang.youtuber_panzerknacker, d: 'https://www.youtube.com/user/pzkpasch'},
    {t: lang.youtuber_flamu, d: 'https://www.youtube.com/user/cheesec4t'},
    {t: lang.youtuber_yuro, d: 'https://www.youtube.com/user/spzjess'},
    {t: lang.youtuber_iChaseGaming, d: 'https://www.youtube.com/user/ichasegaming'},
    {t: lang.youtuber_NoZoupForYou, d: 'https://www.youtube.com/user/ZoupGaming'}];
  }

  render() {
    const { container, searchBar } = styles;
    const { search } = this.state;

    return (
      <Surface style={container}>
        <SafeAreaView style={{flex: 1}}>
          <Searchbar value={search} style={searchBar} placeholder={lang.search_placeholder}
            onChangeText={text => this.setState({search: text})} autoCorrect={false} autoCapitalize='none'/>
          { this.renderContent() }
        </SafeAreaView>
        <BackButton />
      </Surface>
    );
  }

  renderContent() {
    const { icon, scroll } = styles;
    const { search } = this.state;
    if (search.length > 0) {
      return null;
    } else {
      return (
        <ScrollView showsVerticalScrollIndicator={false}
          contentContainerStyle={scroll}>
          <List.Section title={lang.wiki_section_title}>
            { this.wiki.map(item => { return (
              <List.Item title={item.t} style={{padding: 0, paddingLeft: 8}} onPress={() => console.log('Placeholder')} key={item.t}
              left={() => <List.Icon style={icon} color={Colors.blue300} icon={item.i}/>}
              right={() => isAndroid ? null : <List.Icon color={Colors.grey500} icon='keyboard-arrow-right'/>} />
            )})}
          </List.Section>
          <List.Section title={lang.extra_section_title}>
            <List.Accordion title={lang.website_title} >
              { this.websites.map(item => { return (
                <List.Item title={item.t} description={item.d} key={item.t}
                onPress={() => Linking.openURL(item.d)}/>
              )})}
            </List.Accordion>
            <List.Accordion title={lang.youtuber_title}>
              { this.youtubers.map(item => { return (
                <List.Item title={item.t} description={item.d} key={item.t}
                onPress={() => Linking.openURL(item.d)}/>
              )})}
            </List.Accordion>
          </List.Section>
          <WoWsInfo />
        </ScrollView>
      )
    }
  }
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
  },
  icon: {
    backgroundColor: Colors.blueGrey50, 
    borderRadius: 100
  },
  searchBar: {
    position: 'absolute',
    zIndex: 2,
    top: isIphoneX ? 56 : 16,
    left: 16, right: 16,
    borderRadius: 100
  },
  scroll: {
    paddingTop: 64,
  }
});

export { Menu };
