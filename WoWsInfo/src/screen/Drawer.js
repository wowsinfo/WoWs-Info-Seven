import React, { Component } from 'react'
import { Text, StyleSheet, ScrollView, View } from 'react-native';
import { GREY } from 'react-native-material-color';
import language from '../constant/language';
import { DrawerCell, TextCell } from '../component';
import { Divider } from 'react-native-elements';
import { VERSION } from '../constant/value';
import { navStyle } from '../constant/colour';

export default class Drawer extends Component {
  render() {
    const { viewStyle, textStyle, titleStyle, dividerStyle, versionStyle } = styles;    
    return (
      <ScrollView style={viewStyle} contentContainerStyle={{padding: 8}} showsVerticalScrollIndicator={false}>
          <Text style={titleStyle}>{language.drawer_wiki}</Text>
          <DrawerCell icon={require('../img/Achievement.png')} title={language.wiki_achievement}/>
          <DrawerCell icon={require('../img/Warship.png')} title={language.wiki_warship}/>
          <DrawerCell icon={require('../img/Upgrade.png')} title={language.wiki_upgrade}/>
          <DrawerCell icon={require('../img/Camouflage.png')} title={language.wiki_flag_camouflage}/>
          <DrawerCell icon={require('../img/Commander.png')} title={language.wiki_commander}/>
          <DrawerCell icon={require('../img/Map.png')} title={language.wiki_map}/>
          <DrawerCell icon={require('../img/Collection.png')} title={language.wiki_collection}/>
          <View style={dividerStyle}><Divider /></View>
          <TextCell title={language.drawer_settings} onPress={() => this.pushToScreen('info.settings', language.settings_tab_title)}/>
          <Text style={versionStyle}>{VERSION}</Text>
      </ScrollView>
    )
  }

  /**
   * Push to a certain screen
   * @param {*} screen 
   * @param {*} name 
   */
  pushToScreen(screen, name) {
    console.log(screen, name);

    // Hide drawer
    this.props.navigator.toggleDrawer({
      side: 'left',
      to: 'closed'
    });

    this.props.navigator.push({
      screen: screen,
      title: name,
      navigatorStyle: navStyle()
    })
  }
}

const styles = StyleSheet.create({
  viewStyle: {
    flex: 1, backgroundColor: 'white', width: '90%'
  },
  dividerStyle: {
    marginTop: 16
  },
  textStyle: {
    paddingTop: 8, color: GREY[800],
    fontSize: 36, fontWeight: 'bold'
  },
  titleStyle: {
    fontWeight: 'bold',
    color: GREY[800]
  },
  versionStyle: {
    fontSize: 10, fontWeight: 'bold',
    marginTop: 8, padding: 8
  }
})
