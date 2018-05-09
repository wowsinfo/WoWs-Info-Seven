import React, { Component } from 'react'
import { View, Text, Button, ScrollView, StyleSheet, Linking } from 'react-native';
import language from '../../constant/language';
import store from 'react-native-simple-store';
import { WoWsTouchable } from '../../component';
import SelectInput from 'react-native-select-input-ios';
import { navStyle, getTheme } from '../../constant/colour';
import { Divider } from 'react-native-elements';
import { VERSION, Developer, Github, LocalData } from '../../constant/value';
import { GREY } from 'react-native-material-color';
import { DataManager } from '../../core';
import { startApp, loadingData } from '../../app/App';

export default class Settings extends Component {
  state = { langAPI: api_language, langNews: news_language }

  render() {
    return (
      <ScrollView>
        { this.renderAbout() }        
        { this.renderLanguage() }
        { this.renderTheme() }
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

    // Create language list
    let api = [];
    for (key in data.language) api.push({value: key, label: data.language[key]})
    // News language
    let newsAll = [['ru'], ['cs', 'de', 'es', 'fr', 'it', 'pl', 'tr', 'en'], 
      ['es-mx', 'pt-br', 'en'], ['ja', 'ko', 'th', 'zh-tw', 'en']];
    let news = [];
    for (var i = 0; i < newsAll[server].length; i++) 
      news.push({value: newsAll[server][i], label: newsAll[server][i]});

    const { langAPI, langNews } = this.state;
    return (
      <View style={basicViewStyle}>
        { this.renderTitle(language.settings_language_title) }
        <View style={horizonntalViewStyle}>
          <Text style={basicTextStyle}>{language.settings_api_language}</Text>
          <SelectInput style={basicTextStyle} cancelKeyText={language.settings_cancel} submitKeyText={language.settings_done}
            options={api} value={langAPI} mode='dropdown' onSubmitEditing={(value, index) => {
              this.props.navigator.push({
                screen: 'app.wowsinfo',
                navigatorStyle: navStyle()
              })
              this.setState({langAPI: value});
              global.api_language = value;
              store.save(LocalData.api_language, value);
              DataManager.UpdateLocalData().then(() => startApp())
            }}/>
        </View>
        <View style={horizonntalViewStyle}>
          <Text style={basicTextStyle}>{language.settings_news_language}</Text>            
          <SelectInput style={basicTextStyle} cancelKeyText={language.settings_cancel} submitKeyText={language.settings_done}
            options={news} value={langNews} mode='dropdown' onSubmitEditing={(value, index) => {
              this.setState({langNews: value});
              global.news_language = value;
              store.save(LocalData.news_language, value);
            }}/>            
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
        { this.renderEntry(language.settings_remove_ads, null) }
        { this.renderEntry(language.settings_donation, null) }
        { this.renderEntry(language.settings_restore_purchase, null) }        
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
        { this.renderEntry(language.settings_email_feedback, () => Linking.openURL(Developer)) }        
        { this.renderEntry(language.settings_source_code, () => Linking.openURL(Github)) }        
        { /*this.renderEntry(language.settings_write_review, null)*/ }                    
        { /*this.renderEntry(language.settings_open_source_library, null)*/ }                    
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
    padding: 8, color: 'black', flex: 1,
    paddingTop: 16,
    fontSize: 16, fontWeight: '300'
  }
})