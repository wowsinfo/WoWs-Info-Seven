import React, { Component } from 'react';
import { ScrollView } from 'react-native';
import { View } from 'react-native-animatable';
import { DrawerCell } from '../../component';
import { navStyle } from '../../constant/colour';

export default class Wiki extends Component {
  render() {
    const { achievement, commander, consumable, collection } = data;    
    return (
      <ScrollView>
        <View animation='fadeInRight' style={{padding: android ? 0 : 8}}>
          <DrawerCell icon={require('../../img/Achievement.png')} title={language.wiki_achievement} onPress={() => this.pushToWiki(language.wiki_achievement, {info: achievement})}/>
          <DrawerCell icon={require('../../img/Warship.png')} title={language.wiki_warship} />
          <DrawerCell icon={require('../../img/Upgrade.png')} title={language.wiki_upgrade} onPress={() => this.pushToWiki(language.wiki_upgrade, {info: consumable, upgrade: true})}/>
          <DrawerCell icon={require('../../img/Camouflage.png')} title={language.wiki_flag_camouflage} onPress={() => this.pushToWiki(language.wiki_flag_camouflage, {info: consumable})}/>
          <DrawerCell icon={require('../../img/Commander.png')} title={language.wiki_commander} onPress={() => this.pushToWiki(language.wiki_commander, {info: commander})}/>
          <DrawerCell icon={require('../../img/Map.png')} title={language.wiki_map}/>
          <DrawerCell icon={require('../../img/Collection.png')} title={language.wiki_collection} onPress={() => this.pushToWiki(language.wiki_collection, {info: collection})}/>
        </View>
      </ScrollView>
    )
  }
  
  pushToWiki(title, info) {
    // Close drawer for android
    if (android) this.props.drawer();
    console.log(this.props);
    this.props.navigator.push({
      screen: 'wiki.basic',
      title: title,
      passProps: info,
      navigatorStyle: navStyle()
    })
  }
}

