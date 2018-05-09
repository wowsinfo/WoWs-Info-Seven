import React, { Component } from 'react'
import { View, Text, Button, ScrollView, StyleSheet } from 'react-native';
import language from '../../constant/language';
import SelectInput from 'react-native-select-input-ios';
import { navStyle } from '../../constant/colour';
import { Divider } from 'react-native-elements';

export default class Settings extends Component {
  render() {
    return (
      <ScrollView>
        { this.renderLanguage() }
        { this.renderTheme() }
        { this.renderIAP() }
        { this.renderAbout() }
      </ScrollView>
    )
  }

  renderTitle = (title) => {
    const { basicHeaderStyle } = styles;
    return <Text style={basicHeaderStyle}>{title}</Text>
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
          <SelectInput labelStyle={basicTextStyle} cancelKeyText={language.settings_cancel} submitKeyText={language.settings_done}
            value={'Hello'}/>
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
    const { basicViewStyle } = styles;    
    return (
      <View style={basicViewStyle}>
        { this.renderTitle(language.settings_theme_title) }
        <Button title={language.settings_theme} onPress={this.showTheme}/>
      </View>
    )
  }

  /**
   * Render In-app purchase settings
   * Donantion, Remove ads and restore purchase
   */
  renderIAP = () => {
    const { basicViewStyle } = styles;    
    return (
      <View style={basicViewStyle}>
        { this.renderTitle(language.settings_iap_title) }
      </View>
    )
  }

  /**
   * Render about section
   */
  renderAbout = () => {
    const { basicViewStyle } = styles;
    return (
      <View style={basicViewStyle}>
        { this.renderTitle(language.settings_about_title) }
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
    borderWidth: 1, borderRadius: 8, 
    flex: 1, margin: 8
  },
  horizonntalViewStyle: {
    flexDirection: 'row', justifyContent: 'space-around'
  },
  basicHeaderStyle: {
    fontWeight: 'bold', fontSize: 16,
    margin: 8
  },
  basicTextStyle: {
    padding: 8, fontSize: 14
  }
})