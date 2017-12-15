import React from 'react';
import { View, Text } from 'react-native';
import { WoWsLoading } from '../../component';
import ModalDropdown from 'react-native-modal-dropdown';
import { styles } from './SettingsScreenStyles';
import { DataManager } from '../../core';
import { localDataName } from '../../constant/value';
import store from 'react-native-simple-store';
import strings from '../../localization';

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

    this.app = ['English', '简体中文', '繁体中文', '日本語'];
  }

  render() {
    if (this.state.isUpdating) return <WoWsLoading />
    else {
      return (
        <View>
          <ModalDropdown onSelect={this.changeApiLanguage} style={btnStyle} textStyle={textStyle} showsVerticalScrollIndicator={false} defaultValue={strings.api_language} options={this.api}/>
          <ModalDropdown onSelect={this.changeAppLanguage} style={btnStyle} defaultValue={strings.app_language} options={this.app}/>
          <ModalDropdown onSelect={this.changeNewsLanguage} style={btnStyle} defaultValue={strings.news_language} options={this.news}/>
        </View>
      )
    }
  }

  changeApiLanguage = (index, value) => {
    for (key in global.languageJson) {
      // Find its code
      if (global.languageJson[key] == value) {
        // Update Data HERE
        global.apiLanguage = key;
        store.update(localDataName.apiLanguage, key);
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
    store.update(localDataName.newsLanguage, value);
  }

  changeAppLanguage = (index, value) => {
    let langCode = ['en', 'zh', 'zh-tw', 'ja'];
    let newLang = langCode[index];
    // Update global, store
    global.appLanguage = newLang;
    store.update(localDataName.appLanguage, newLang);
  }
}

const { btnStyle, textStyle } = styles;

export {SettingsScreen}