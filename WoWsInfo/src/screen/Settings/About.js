import React, { Component } from 'react';
import { View, Linking, StyleSheet, Text } from 'react-native';
import ElevatedView from 'react-native-elevated-view';
import { navStyle } from '../../constant/colour';
import { Developer, Github, GooglePlay, AppStore, VERSION, AndroidVersion, IOSVersion } from '../../constant/value';
import { DrawerCell } from '../../component';
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
    const { basicViewStyle, textStyle } = styles;
    const appVersion = (android ? AndroidVersion : IOSVersion) + ' (' + game_version + ')';
    return (
      <View>
        <DrawerCell icon={iconsMap['email']} title={language.settings_email_feedback} onPress={() => Linking.openURL(Developer)}/>
        <DrawerCell icon={iconsMap['logo-github']} title={language.settings_source_code} onPress={() => Linking.openURL(Github)}/>
        <DrawerCell icon={iconsMap['star']} title={language.settings_write_review} onPress={() => Linking.openURL(android ? GooglePlay : AppStore)}/>
        <DrawerCell icon={iconsMap['md-git-commit']} title={language.settings_open_source_library} onPress={() => this.props.navigator.push({
          screen: 'settings.opensource', title: language.settings_open_source_library, navigatorStyle: navStyle()
        })}/>
        <Divider />
        { this.renderSpecialThanks() }
        <Text style={textStyle}>{appVersion}</Text>        
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
  },
  textStyle: {
    margin: 16
  }
})