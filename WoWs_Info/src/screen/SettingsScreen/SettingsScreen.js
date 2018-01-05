import React from 'react';
import { View, Button, ScrollView, Platform, Alert, AsyncStorage } from 'react-native';
import { Text } from 'react-native-elements';
import { WoWsLoading } from '../../component';
import ModalDropdown from 'react-native-modal-dropdown';
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
      case 0: this.news = ['ru']; break;
      case 1: this.news = ['cs', 'de', 'en', 'es', 'fr', 'it', 'pl', 'tr']; break;
      case 2: this.news = ['en', 'es-mx', 'pt-br']; break;
      case 3: this.news = ['en', 'ja', 'ko', 'th', 'zh-tw']; break;
      default: this.news = ['zh']; break;
    } 

    this.app = ['English', '简体中文', '繁體中文', '日本語'];
  }

  render() {
    if (this.state.isUpdating) return <WoWsLoading />
    else {
      return (
        <View style={{flex: 1}}>
          <ScrollView>
            <Text h1>{strings.language_header}</Text>
            <ModalDropdown onSelect={this.changeApiLanguage} style={btnStyle} textStyle={textStyle} showsVerticalScrollIndicator={false} defaultValue={strings.api_language} options={this.api}/>
            <ModalDropdown onSelect={this.changeAppLanguage} style={btnStyle} textStyle={textStyle} defaultValue={strings.app_language} options={this.app}/>
            <ModalDropdown onSelect={this.changeNewsLanguage} style={btnStyle} textStyle={textStyle} defaultValue={strings.news_language} options={this.news}/>
            <Text h1>{strings.theme_header}</Text>
            <Button onPress={this.changeThemeColour} title={strings.change_theme}/>          
            <Text h1>{strings.about_header}</Text>
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
          AsyncStorage.removeItem(localDataName.playerList);
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