import React, { Component } from 'react';
import { View, Linking, StyleSheet, Text } from 'react-native';
import { navStyle } from '../../constant/colour';
import { Developer, Github, GooglePlay, AppStore, VERSION, AndroidVersion, IOSVersion } from '../../constant/value';
import { SettingCell } from '../../component';
import language from '../../constant/language';
import { iconsMap } from '../../constant/icon';
import { Divider } from 'react-native-elements';

export default class About extends Component {
  constructor(props) {
    super(props);
    this.props.navigator.setOnNavigatorEvent(this.onNavigatorEvent.bind(this));
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
    const { basicViewStyle } = styles;
    return (
      <View>
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
        { this.renderSpecialThanks() }    
      </View>
    )
  }
  
  /**
   * To thank who helped me in making this application
   */
  renderSpecialThanks() {
    return null;
  }
}

const styles = StyleSheet.create({
  basicViewStyle: {
    flex: 1, margin: 8
  }
})