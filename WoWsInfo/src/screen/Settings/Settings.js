import React, { Component } from 'react'
import { View, Text, Button, ScrollView, StyleSheet, Linking, Alert } from 'react-native';
import language from '../../constant/language';
import store from 'react-native-simple-store';
import ElevatedView from 'react-native-elevated-view';
import { WoWsTouchable, QuickInput, TextCell } from '../../component';
import SelectInput from 'react-native-select-input-ios';
import { navStyle, getTheme } from '../../constant/colour';
import { Divider } from 'react-native-elements';
import { Developer, Github, LocalData, AndroidVersion, IOSVersion, AppStore, GooglePlay } from '../../constant/value';
import { GREY } from 'react-native-material-color';
import { DataManager } from '../../core';
import { startApp } from '../../app/App';

import { NativeModules } from 'react-native'
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
    const appVersion = (android ? AndroidVersion : IOSVersion) + ' (' + game_version + ')';
    return (
      <ScrollView>
        { this.renderAbout() }        
        { this.renderLanguage() }
        { this.renderTheme() }
        { android ? null : this.renderIAP() }
        <Text style={styles.versionStyle}>{appVersion}</Text>
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
    return <TextCell title={text} onPress={onPress}/>
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
      <ElevatedView elevation={2} style={basicViewStyle}>
        { this.renderTitle(language.settings_language_title) }
        <View style={horizonntalViewStyle}>
          <Text style={basicTextStyle}>{language.settings_api_language}</Text>
          <QuickInput options={api} value={langAPI} action={(value, index) => {
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
          <QuickInput options={news} value={langNews} action={(value, index) => {
              this.setState({langNews: value});
              global.news_language = value;
              store.save(LocalData.news_language, value);
            }}/>            
        </View>
      </ElevatedView>
    )
  }

  /**
   * Render theme settings
   * 
   */
  renderTheme = () => {
    const { basicViewStyle, basicTextStyle } = styles;    
    return (
      <ElevatedView elevation={2} style={basicViewStyle}>
        { this.renderTitle(language.settings_theme_title) }
        { this.renderEntry(language.settings_theme, this.showTheme) }
      </ElevatedView>
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
        { !ads ? null : this.renderEntry(language.settings_remove_ads, () => this.buyIAP()) }
        { /*this.renderEntry(language.settings_donation, null)*/ }
        { !ads ? null : this.renderEntry(language.settings_restore_purchase, () => this.restoreIAP()) }        
      </View>
    )
  }

  /**
   * Render about section
   */
  renderAbout = () => {
    const { basicViewStyle, basicTextStyle } = styles;
    return (
      <ElevatedView elevation={2} style={basicViewStyle}>
        { this.renderEntry(language.settings_email_feedback, () => Linking.openURL(Developer)) }        
        { this.renderEntry(language.settings_source_code, () => Linking.openURL(Github)) }        
        { this.renderEntry(language.settings_write_review, () => Linking.openURL(android ? GooglePlay : AppStore)) }                    
        { this.renderEntry(language.settings_open_source_library, () => this.props.navigator.push({
          screen: 'settings.opensource', title: language.settings_open_source_library, navigatorStyle: navStyle()
        })) }                    
      </ElevatedView>
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
    alignItems: 'center'
  },
  basicHeaderStyle: {
    fontSize: 12, fontWeight: 'bold',
    padding: 8, paddingTop: 8, paddingBottom: 8
  },
  basicTextStyle: {
    padding: 8, color: 'black', flex: 1,
    fontSize: 14, fontWeight: 'bold'
  }
})