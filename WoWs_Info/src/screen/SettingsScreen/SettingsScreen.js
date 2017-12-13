import React from 'react';
import { View, Text } from 'react-native';
import ModalDropdown from 'react-native-modal-dropdown';
import { styles } from './SettingsScreenStyles';
import strings from '../../localization';

class SettingsScreen extends React.PureComponent {
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
    return (
      <View>
        <ModalDropdown style={btnStyle} textStyle={textStyle} showsVerticalScrollIndicator={false} defaultValue={strings.api_language} options={this.api}/>
        <ModalDropdown style={btnStyle} defaultValue={strings.app_language} options={this.app}/>
        <ModalDropdown style={btnStyle} defaultValue={strings.news_language} options={this.news}/>
      </View>
    )
  }
}

const { btnStyle, textStyle } = styles;

export {SettingsScreen}