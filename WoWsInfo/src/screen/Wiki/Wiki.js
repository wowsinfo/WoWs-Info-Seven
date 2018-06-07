import React, { Component } from 'react';
import { ScrollView } from 'react-native';
import { View } from 'react-native-animatable';
import { WikiCell } from '../../component';
import { navStyle } from '../../constant/colour';
import language from '../../constant/language';
import { iconsMap } from '../../constant/icon';
import { LocalData } from '../../constant/value';

export default class Wiki extends Component {
  constructor(props) {
    super(props);
    this.props.navigator.setOnNavigatorEvent(this.onNavigatorEvent.bind(this));    
  }

  onNavigatorEvent(event) {
    if (event.id === 'bottomTabSelected') {
      let store = require('react-native-simple-store');
      store.save(LocalData.saved_tab, 2);
    }
  }

  render() {
    const { achievement, commander, consumable, collection, warship, map } = data;
    return (
      <ScrollView>
        <View ref={(ref) => (this.preview = ref)} animation='fadeInRight' style={{padding: android ? 0 : 8}}>
          <WikiCell icon={require('../../img/Achievement.png')} 
            title={language.wiki_achievement + ' (' + Object.keys(achievement).length + ')'} 
            onPress={() => this.pushToBasic(language.wiki_achievement, {info: achievement}, true)}/>
          <WikiCell icon={require('../../img/Warship.png')} 
            title={language.wiki_warship + ' (' + Object.keys(warship).length + ')'} 
            onPress={() => this.pushToWarship()}/>
          <WikiCell icon={require('../../img/Upgrade.png')} title={language.wiki_upgrade} 
            onPress={() => this.pushToBasic(language.wiki_upgrade, {info: consumable, upgrade: true})}/>
          <WikiCell icon={require('../../img/Camouflage.png')} 
            title={language.wiki_flag_camouflage} 
            onPress={() => this.pushToBasic(language.wiki_flag_camouflage, {info: consumable})}/>
          <WikiCell icon={require('../../img/CommanderSkill.png')} 
            title={language.wiki_commander} onPress={() => this.pushToBasic(language.wiki_commander, {info: commander})}/>
          <WikiCell icon={require('../../img/Map.png')} 
            title={language.wiki_map + ' (' + Object.keys(map).length + ')'} onPress={() => this.pushToMap()}/>
          <WikiCell icon={require('../../img/Collection.png')} 
            title={language.wiki_collection} 
            onPress={() => this.pushToBasic(language.wiki_collection, {info: collection})}/>
        </View>
      </ScrollView>
    )
  }
  
  /**
   * Push to basic screen
   * @param {string} title 
   * @param {*} info 
   */
  pushToBasic(title, info, preview) {
    // Close drawer for android
    if (android) this.props.drawer();
    this.props.navigator.push({
      screen: 'wiki.basic',
      title: title,
      passProps: info,
      navigatorStyle: navStyle()
    })
  }

  /**
   * Push to map screen
   */
  pushToMap = () => {
    // Close drawer for android
    if (android) this.props.drawer();
    this.props.navigator.push({
      screen: 'wiki.map',
      title: language.wiki_map,
      navigatorStyle: navStyle()
    })
  }

  /**
   * Push to warship screen
   */
  pushToWarship() {
    // Close drawer for android
    if (android) this.props.drawer();
    this.props.navigator.push({
      screen: 'wiki.ship',
      title: language.wiki_warship,
      navigatorButtons: {
        rightButtons: [ 
          {id: 'reset', icon: iconsMap['undo']},
          {id: 'filter', icon: iconsMap['filter']}
        ]
      },
      navigatorStyle: navStyle()
    })
  }
}

