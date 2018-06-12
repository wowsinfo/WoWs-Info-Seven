import React, { Component } from 'react'
import { View, Image, Text, StyleSheet, ScrollView } from 'react-native';
import { GREY } from 'react-native-material-color';
import language from '../constant/language';
import { DrawerCell, TextCell } from '../component';
import { Divider } from 'react-native-elements';
import { navStyle, getTheme, getTextColour } from '../constant/colour';
import Wiki from './Wiki/Wiki';
import { iconsMap } from '../constant/icon';
import { AndroidVersion, IOSVersion } from '../constant/value';

export default class Drawer extends Component {
  state = { selected: '' }

  render() {
    const { viewStyle, titleStyle, versionStyle, imageStyle, imageViewStyle } = styles;  
    const appVersion = (android ? AndroidVersion : IOSVersion) + ' (' + game_version + ')';
    return (
      <ScrollView style={[viewStyle, {backgroundColor: getTheme()}]} showsVerticalScrollIndicator={false}>
        <View style={[imageViewStyle, {backgroundColor: getTheme()}]}><Image source={require('../img/Warship-Android.png')} style={[imageStyle, {tintColor: getTextColour()}]}/></View>
        <DrawerCell icon={iconsMap['home']} title='Home' onPress={() => this.pushToHome()}/>
        <Divider />
        <Wiki navigator={this.props.navigator} drawer={this.closeDrawer}/>       
        <Divider />        
        <DrawerCell icon={iconsMap['ios-settings']} title={language.drawer_settings} onPress={() => this.pushToScreen('info.settings', language.settings_tab_title)}/>
        <Text style={[versionStyle, {color: getTextColour()}]}>{appVersion}</Text>
      </ScrollView>
    )
  }

  /**
   * Pop everything
   */
  pushToHome() {
    this.closeDrawer();
    this.props.navigator.popToRoot({animated: true});
  }

  /**
   * Push to a certain screen
   * @param {*} screen 
   * @param {*} name 
   */
  pushToScreen(screen, name) {
    console.log(screen, name);
    // Close drawer and push to screen
    this.closeDrawer();
    this.props.navigator.push({
      screen: screen,
      title: name,
      navigatorStyle: navStyle()
    })
  }

  /**
   * Close drawer for android
   */
  closeDrawer = () => {
    // Hide drawer
    this.props.navigator.toggleDrawer({
      side: 'left',
      animation: false,
      to: 'closed'
    });
  }
}

const styles = StyleSheet.create({
  viewStyle: {
    flex: 1, backgroundColor: 'white', width: '90%'
  },
  titleStyle: {
    fontWeight: 'bold', padding: 8,
    color: GREY[800]
  },
  versionStyle: {
    fontSize: 12, fontWeight: '500',
    paddingLeft: 16, padding: 8
  },
  imageViewStyle: {
    paddingLeft: 16, height: 128,
    justifyContent: 'center'
  },
  imageStyle: {
    height: 80, width: 80
  }
})
