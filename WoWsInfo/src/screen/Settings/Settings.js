import React, { Component } from 'react'
import { View, Text, Button, ScrollView, StyleSheet, Linking } from 'react-native';
import language from '../../constant/language';
import { WoWsTouchable } from '../../component';
import SelectInput from 'react-native-select-input-ios';
import { navStyle, getTheme } from '../../constant/colour';
import { Divider } from 'react-native-elements';
import { VERSION } from '../../constant/value';
import { GREY } from 'react-native-material-color';

export default class Settings extends Component {
  render() {
    return (
      <ScrollView>
        { this.renderAbout() }        
        { this.renderLanguage() }
        { this.renderTheme() }
        { this.renderIAP() }
        <Text style={styles.versionStyle}>{VERSION}</Text>
      </ScrollView>
    )
  }

  /**
   * Render section header
   */
  renderTitle = (title) => {
    const { basicHeaderStyle } = styles;
    return (
      <View>
        <Divider />
        <Text style={[basicHeaderStyle, {color: getTheme()}]}>{title}</Text>
      </View>
    )
  } 

  /**
   * Render entry button
   */
  renderEntry = (text, onPress) => {
    return (
      <WoWsTouchable onPress={onPress}>
        <Text style={styles.basicTextStyle}>{text}</Text>
      </WoWsTouchable>
    )
  }

  /**
   * Render language settings
   * News and API language
   */
  renderLanguage = () => {
    const { horizonntalViewStyle, basicTextStyle, basicViewStyle } = styles;
    return (
      <View style={basicViewStyle}>
        { this.renderTitle(language.settings_language_title) }
        <View style={horizonntalViewStyle}>
          <SelectInput labelStyle={basicTextStyle} cancelKeyText={language.settings_cancel} submitKeyText={language.settings_done}/>
          <SelectInput labelStyle={basicTextStyle} cancelKeyText={language.settings_cancel} submitKeyText={language.settings_done}/>
        </View>
      </View>
    )
  }

  /**
   * Render theme settings
   * 
   */
  renderTheme = () => {
    const { basicViewStyle, basicTextStyle } = styles;    
    return (
      <View style={basicViewStyle}>
        { this.renderTitle(language.settings_theme_title) }
        { this.renderEntry(language.settings_theme, this.showTheme) }
      </View>
    )
  }

  /**
   * Render In-app purchase settings
   * Donantion, Remove ads and restore purchase
   */
  renderIAP = () => {
    const { basicViewStyle, basicTextStyle } = styles;    
    return (
      <View style={basicViewStyle}>
        { this.renderTitle(language.settings_iap_title) }
        { this.renderEntry(language.settings_remove_ads, this.showTheme) }
        { this.renderEntry(language.settings_donation, this.showTheme) }
        { this.renderEntry(language.settings_restore_purchase, this.showTheme) }        
      </View>
    )
  }

  /**
   * Render about section
   */
  renderAbout = () => {
    const { basicViewStyle, basicTextStyle } = styles;
    return (
      <View style={basicViewStyle}>
        { this.renderEntry(language.settings_email_feedback, this.showTheme) }        
        { this.renderEntry(language.settings_source_code, this.showTheme) }        
        { this.renderEntry(language.settings_write_review, this.showTheme) }                    
      </View>
    )
  }

  /**
   * Push to theme screen
   */
  showTheme = () => {
    this.props.navigator.push({
      screen: 'settings.theme',
      title: language.settings_theme,
      navigatorStyle: navStyle()
    })
  }
}

const styles = StyleSheet.create({
  basicViewStyle: {
    elevation: 1,
    flex: 1, margin: 8
  },
  versionStyle: {
    padding: 16, fontSize: 12, 
    color: GREY[500], fontWeight: '300'
  },
  horizonntalViewStyle: {
    flexDirection: 'row', justifyContent: 'space-around'
  },
  basicHeaderStyle: {
    fontWeight: 'bold', fontSize: 14,
    margin: 8
  },
  basicTextStyle: {
    padding: 8, color: 'black',
    fontSize: 16, fontWeight: '300'
  }
})