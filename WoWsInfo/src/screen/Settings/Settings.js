import React, { Component } from 'react';
import { View, Text, Button, ScrollView, StyleSheet, Linking, Alert } from 'react-native';
import language from '../../constant/language';
import store from 'react-native-simple-store';
import { QuickInput, SettingCell, SettingView } from '../../component';
import { navStyle, getTheme } from '../../constant/colour';
import { Divider } from 'react-native-elements';
import { LocalData, AndroidVersion, IOSVersion, AppStore, GooglePlay, Developer, Github } from '../../constant/value';
import { GREY } from 'react-native-material-color';
import { DataManager } from '../../core';
import { startApp } from '../../app/App';

import { NativeModules } from 'react-native'
import { iconsMap } from '../../constant/icon';
const { InAppUtils } = NativeModules;
products = ['com.yihengquan.WoWsInfo.Pro'];

export default class Settings extends Component {
  constructor(props) {
    super(props);
    this.state = { langAPI: api_language, langNews: news_language, price: '' } 
    this.props.navigator.setOnNavigatorEvent(this.onNavigatorEvent.bind(this));

    if (!android) InAppUtils.loadProducts(products, (error, products) => {
      console.log(products);
      if (products[0] != undefined) {
        const { currencyCode, price } = products[0];
        this.setState({price: price + ' ' + currencyCode}) 
      } 
    });
  }

  onNavigatorEvent(event) {
    switch (event.id) {
      case "willAppear":
        this.props.navigator.setDrawerEnabled({side: "left", enabled: false});
        break;
      case "willDisappear":
        this.props.navigator.setDrawerEnabled({side: "left", enabled: true});
        break;
    }
  }

  render() {
    return (
      <ScrollView style={{backgroundColor: android ? 'white' : '#EFEFF4'}}>       
        { this.renderLanguage() }
        { this.renderTheme() }
        { android ? null : this.renderIAP() }
        { this.renderWoWsInfo() }
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
    return <SettingCell title={text} onPress={onPress}/>
  }

  /**
   * Render language settings
   * News and API language
   */
  renderLanguage = () => {
    const { horizonntalViewStyle, basicTextStyle } = styles;

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
      <SettingView header={language.settings_language_title}>
        <View style={{backgroundColor: 'white', paddingLeft: 8}}>
          <View style={horizonntalViewStyle}>
            <Text style={basicTextStyle}>{language.settings_api_language}</Text>
            <QuickInput options={api} value={langAPI} action={(value, index) => {
              this.props.navigator.push({
                screen: 'app.wowsinfo',
                navigatorStyle: navStyle(),
                passProps: {api: true}
              })
              this.setState({langAPI: value});
              global.api_language = value;
              store.save(LocalData.api_language, value);
              DataManager.UpdateLocalData().then(() => startApp())
            }}/>
          </View>
          <View style={horizonntalViewStyle}>
            <Text style={basicTextStyle}>{language.settings_news_language}</Text>   
            <QuickInput options={news} value={langNews} action={(value, index) => {
                this.setState({langNews: value});
                global.news_language = value;
                store.save(LocalData.news_language, value);
              }}/>            
          </View>
        </View>
      </SettingView>
    )
  }

  /**
   * Render theme settings
   * 
   */
  renderTheme = () => {
    return (
      <SettingView header={language.settings_theme_title}>
        { this.renderEntry(language.settings_theme, this.showTheme) }        
      </SettingView>
    )
  }

  renderWoWsInfo = () => {
    const appVersion = (android ? AndroidVersion : IOSVersion) + ' (' + game_version + ')';
    return (
      <SettingView header='WoWs Info' footer={appVersion}>
        <SettingCell title={language.settings_email_feedback} subtitle={language.settings_email_feedback_sub}
          divider image={iconsMap['email']} onPress={() => Linking.openURL(Developer)}/>
        <SettingCell title={language.settings_source_code} subtitle={language.settings_source_code_sub}
          divider image={iconsMap['logo-github']} onPress={() => Linking.openURL(Github)}/>
        <SettingCell title={language.settings_write_review} 
          divider image={iconsMap['star']} onPress={() => Linking.openURL(android ? GooglePlay : AppStore)}/>
        <SettingCell title={language.settings_open_source_library} 
          image={iconsMap['md-git-commit']} onPress={() => this.props.navigator.push({
          screen: 'settings.opensource', title: language.settings_open_source_library, navigatorStyle: navStyle()
        })}/>
      </SettingView>
    )
  }

  /**
   * Render In-app purchase settings
   * Donantion, Remove ads and restore purchase
   */
  renderIAP = () => {
    const { basicViewStyle, basicTextStyle } = styles;    
    return (
      <SettingView header={language.settings_support_title}>
        { !ads ? null : this.renderEntry(language.settings_remove_ads, () => this.buyIAP()) }
        { /*this.renderEntry(language.settings_donation, null)*/ }
        { !ads ? null : this.renderEntry(language.settings_restore_purchase, () => this.restoreIAP()) }      
      </SettingView>
    )
  }

  /**
   * Remove ads
   */
  buyIAP = () => {
    // Check if payment is possible
    InAppUtils.canMakePayments((canMakePayments) => {
      if(!canMakePayments) {
        Alert.alert(language.iap_no_itunes)
      } else {
        // Buy pro version
        InAppUtils.purchaseProduct(products[0], (error, response) => {
          // NOTE for v3.0: User can cancel the payment which will be available as error object here.
          console.log(response);
          if(response && response.productIdentifier) {
            Alert.alert(language.iap_success);
            global.ads = false;
            store.save(LocalData.has_ads, false);
            startApp();
          } else Alert.alert(language.iap_failed);
        });
      }
   })
  }

  /**
   * Restore purchase  
   */
  restoreIAP = () => {
    InAppUtils.restorePurchases((error, response) => {
      if(error) Alert.alert(language.iap_no_itunes);
      else {
        if (response.length !== 0) {
          response.forEach((purchase) => {
            if (purchase.productIdentifier === products[0]) {
              Alert.alert(language.iap_success);
              global.ads = false;
              store.save(LocalData.has_ads, false);
              startApp();
            }
          });
        }
      }
    });
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
    flex: 1, margin: 8
  },
  versionStyle: {
    padding: 8, fontSize: 12, 
    color: GREY[500], fontWeight: '300'
  },
  horizonntalViewStyle: {
    flexDirection: 'row', justifyContent: 'center',
    alignItems: 'center', margin: -4
  },
  basicHeaderStyle: {
    fontSize: 12, fontWeight: 'bold',
    padding: 8, paddingTop: 8, paddingBottom: 8
  },
  basicTextStyle: {
    padding: 8, flex: 1,
    fontSize: 17, color: GREY[900]
  }
})