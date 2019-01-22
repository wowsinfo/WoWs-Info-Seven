/*
 * WoWsInfo.js
 *
 * This is used as a footer if no name is passed, it is a about button
 */

import React, { Component } from 'react';
import { SafeAreaView, StyleSheet, StatusBar } from 'react-native';
import { Button, Surface } from 'react-native-paper';
import { isAndroid } from 'react-native-device-detection';
import lang from '../../value/lang';
import { Actions } from 'react-native-router-flux';
import { FooterButton } from './FooterButton';
import { SafeAction, random } from '../../core';
import { GREY } from 'react-native-material-color';
import { ThemeBackColour, ThemeColour } from '../../value/colour';

class WoWsInfo extends Component {
  constructor(props) {
    super(props);

    const name = [lang.wowsinfo_black, lang.wowsinfo_go, lang.wowsinfo_new, 
                 lang.wowsinfo_pro, lang.wowsinfo_ultimate, lang.wowsinfo_ultra, lang.wowsinfo_white, 
                 lang.wowsinfo_x, lang.wowsinfo_y, lang.wowsinfo_z, '>_<', '#', 
                 '0_0', '', '^_^', '★', 'α', 'θ', 'Ω', 'Ф', '∞', '░', '( ͡° ͜ʖ ͡°)', '¯\_(ツ)_/¯',
                 '2018', '?!', '!!', '?!', '2017', '2016'];

    // 50% of the time, it will be the app name
    let r = random(10);
    if (r < 5) this.lucky = lang.app_name;
    else this.lucky = `WoWs Info ${name[random(name.length)]}`;
  }

  render() {
    const { container, safeView } = styles;
    const { children, style } = this.props;
    return (
      <Surface style={[container, style]}>
        <SafeAreaView style={[safeView, ThemeBackColour()]}>
          <StatusBar barStyle={DARKMODE ? 'light-content' : 'dark-content'} 
            backgroundColor={ThemeColour()}/>
          <Surface style={container}>
            { children }
          </Surface>
          { this.renderFooter() }
        </SafeAreaView>
      </Surface>
    )
  };

  renderFooter() {
    const { text, footer } = styles;
    const { title, noRight, noLeft, home, onPress, about } = this.props;

    let shouldDisable = (!onPress && !about)

    return (
      <Surface style={[footer, ThemeBackColour()]}>
        { noLeft ? null : <FooterButton icon={home ? 'settings' : 'home'} left/> }
        <Button disabled={shouldDisable} onPress={this.pressEvent} style={text}>
          { title ? title : this.lucky }
        </Button>
        { noRight ? null : <FooterButton icon={home ? require('../../img/Warship.png') : 'arrow-back'}/> }
      </Surface>
    )
  }

  /**
   * Handle press event, dont always go to about page
   */
  pressEvent = () => {
    const { onPress, about } = this.props;
    if (onPress) return onPress();
    else if (about) return this.navigate();
  }

  /**
   * Navigate to About page
   */
  navigate() {
    SafeAction('About');
  }
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
  },
  text: {
    fontSize: 17, fontWeight: isAndroid ? 'bold' : '300',
    textAlign: 'center', alignSelf: 'center',
    width: '70%',
  },
  safeView: {
    flex: 1,
  },
  footer: {
    height: 48, 
    justifyContent: 'center',
  }
});

export { WoWsInfo };
