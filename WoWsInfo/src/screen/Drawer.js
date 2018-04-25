import React, { Component } from 'react'
import { Text, StyleSheet, ScrollView, View } from 'react-native';
import { GREY } from 'react-native-material-color';
import language from '../constant/language';
import { DrawerCell } from '../component';

export default class Drawer extends Component {
  render() {
    const { scrollStyle, textStyle } = styles;
    return (
      <ScrollView contentContainerStyle={scrollStyle}>
        <DrawerCell icon={require('../img/Achievement.png')} title={language.wiki_achievement}/>
        <DrawerCell icon={require('../img/Warship.png')} title={language.wiki_warship}/>
        <DrawerCell icon={require('../img/Upgrade.png')} title={language.wiki_upgrade}/>
        <DrawerCell icon={require('../img/Camouflage.png')} title={language.wiki_flag_camouflage}/>
        <DrawerCell icon={require('../img/Commander.png')} title={language.wiki_commander}/>
        <DrawerCell icon={require('../img/Map.png')} title={language.wiki_map}/>
        <DrawerCell icon={require('../img/Collection.png')} title={language.wiki_collection}/>
      </ScrollView>
    )
  }
}

const styles = StyleSheet.create({
  scrollStyle: {
    margin: 8, justifyContent: 'center', flex: 1,
    backgroundColor: 'white', borderRadius: 8
  },
  textStyle: {
    paddingTop: 8, color: GREY[800],
    fontSize: 36, fontWeight: 'bold'
  }
})