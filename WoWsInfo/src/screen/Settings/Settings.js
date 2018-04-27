import React, { Component } from 'react'
import { View, Text, Button } from 'react-native';
import language from '../../constant/language';
import { navStyle } from '../../constant/colour';

export default class Settings extends Component {
  render() {
    return (
      <View>
        <Button title={language.settings_theme} onPress={this.showTheme}/>
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