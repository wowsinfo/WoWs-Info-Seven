import React from 'react';
import { View, Button, ScrollView, Platform, Alert, AsyncStorage } from 'react-native';
import { Text, Divider } from 'react-native-elements';
import { WoWsLoading } from '../../component';
import { Dropdown } from 'react-native-material-dropdown';
import { styles } from './SettingsScreenStyles';
import { DataManager, DataStorage } from '../../core';
import { localDataName } from '../../constant/value';
import store from 'react-native-simple-store';
import strings from '../../localization';
import { Actions } from 'react-native-router-flux';

class SettingsScreen extends React.PureComponent {
  state = {
    isUpdating: false,
  }

  componentWillMount() {
    var apiList = [];
    for (key in global.languageJson) apiList.push(global.languageJson[key]);
    this.api = apiList;

    switch (parseInt(global.server)) {
      case 0: this.news = [{value: 'ru'}]; break;
      case 1: this.news = [{value: 'cs'}, {value: 'de'}, {value: 'en'}, {value: 'es'}, {value: 'fr'}, {value: 'it'}, {value: 'pl'}, {value: 'tr'}]; break;
      case 2: this.news = [{value: 'en'}, {value: 'es-mx'}, {value: 'pt-br'}]; break;
      case 3: this.news = [{value: 'en'}, {value: 'ja'}, {value: 'ko'}, {value: 'th'}, {value: 'zh-tw'}]; break;
      default: this.news = [{value: 'zh'}]; break;
    } 

    this.app = ['English', '简体中文', '繁體中文', '日本語'];
  }

  render() {
    if (this.state.isUpdating) return <WoWsLoading />
    else {
      return (
        <View style={{flex: 1}}>
          <ScrollView>
            <Text h3>{strings.language_header}</Text>  
            <Dropdown pickerStyle={{padding: 0, margin: 0}} label={strings.app_language} data={this.app}/>
            <Dropdown label={strings.api_language} data={this.api}/>
            <Dropdown label={strings.news_language} data={this.news} itemCount={5}/>
            <Divider />
            <Text h3>{strings.theme_header}</Text>
            <Button onPress={this.changeThemeColour} title={strings.change_theme}/>  
            <Divider />                    
            <Text h3>{strings.about_header}</Text>
            <Button onPress={this.resetAllData} title={strings.reset_data}/>          
            <Button onPress={this.resetIOSData} title={strings.reset_ios_data}/>                        
          </ScrollView>
        </View>
      )
    }
  }

  resetAllData = () => {
    if (global.canReset) {
      Alert.alert(strings.warning, strings.are_your_sure, [
        {text: 'YES', onPress: () => {
          DataStorage.setupAllData().then(() => {
            global.canReset = false;
            this.props.reset(global.themeColour); 
          })
        }},
        {text: 'NO', onPress: () => console.log('Cancel Pressed')},
      ])
    } else {
      Alert.alert(strings.warning, strings.no_more_reset);
    }
  }

  resetIOSData = () => {
    if (Platform.OS == 'ios') {
      Alert.alert(strings.warning, strings.are_your_sure, [
        {text: 'YES', onPress: () => {
          DataStorage.setupIOSData().then(() => {
            this.props.reset(global.themeColour);
          })
        }},
        {text: 'NO', onPress: () => console.log('Cancel Pressed')},
      ])
    } else {
      Alert.alert(strings.warning, strings.ios_only);
    }
  }

  changeThemeColour = () => {
    Actions.ThemeScreen({reset: this.props.reset});
  }

  changeApiLanguage = (index, value) => {
    for (key in global.languageJson) {
      // Find its code
      if (global.languageJson[key] == value) {
        // Update Data HERE
        global.apiLanguage = key;
        store.save(localDataName.apiLanguage, key);
        // Change WoWsLoading
        this.setState({
          isUpdating: true,
        }, () => {
          DataManager.updateLocalData().then(() => {
            this.setState({
              isUpdating: false,
            })
          });
        })
      }
    }
  }

  changeNewsLanguage = (index, value) => {
    global.newsLanguage = value;
    store.save(localDataName.newsLanguage, value);
  }

  changeAppLanguage = (index, value) => {
    let langCode = ['en', 'zh', 'zh-tw', 'ja'];
    let newLang = langCode[index];
    // Update global, store
    global.appLanguage = newLang;
    store.save(localDataName.appLanguage, newLang);
    strings.setLanguage(newLang);
    // Dont forget to put in a colour here
    this.props.reset(global.themeColour);    
  }
}

const { btnStyle, textStyle } = styles;

export {SettingsScreen}