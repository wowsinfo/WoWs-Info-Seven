/*
 * WoWsInfo.js
 *
 * This is used as a footer if no name is passed, it is a about button
 */

import React, { Component } from 'react';
import { SafeAreaView, StyleSheet, StatusBar } from 'react-native';
import { Button, Surface } from 'react-native-paper';
import { isAndroid } from 'react-native-device-detection';
import { lang } from '../../value/lang';
import { LOCAL } from '../../value/data';
import { FooterButton } from './FooterButton';
import { SafeAction, random } from '../../core';
import { ThemeBackColour, ThemeColour } from '../../value/colour';
import { View } from 'react-native-animatable';
import { AdmobBanner } from './AdmobBanner';

class WoWsInfo extends Component {
  constructor(props) {
    super(props);

    const name = [lang.wowsinfo_black, lang.wowsinfo_go, lang.wowsinfo_new,
                 lang.wowsinfo_pro, lang.wowsinfo_ultimate, lang.wowsinfo_ultra, lang.wowsinfo_white,
                 'X', 'Y', 'Z', '>_<', '#', '0_0', '', '^_^', '★', 'α', 'θ', 'Ω', 'Ф', '∞', '░',
                 '( ͡° ͜ʖ ͡°)', '¯\_(ツ)_/¯', '2018', '?!', '!!', '?!', '2017', '2016', '2019', '2020', '2021', '2022', 
                 'I', 'II', 'III', 'IV', 'V', 'VI', 'VII', 'VIII', 'IX', 'X', 
                 'DD', 'BB', 'CV', 'CA', 'SUB',
                 // People and clans that really supports me during development (I will add more)
                 'Auris2010k', 'HenryQuan', 'Zetesian', 'CJokerLukas', 'VladimirlS', 'CICN', 'FFD'];

    // 80% of the time, it will be the app name
    let r = random(10);
    if (r < 8) this.lucky = lang.app_name;
    else this.lucky = `WoWs Info ${name[random(name.length)]}`;
  }

  render() {
    const { container, safeView, child } = styles;
    const { children, hideAds, empty, style } = this.props;

    let showPro = DATA[LOCAL.proVersion];
    // Add a margin for android devices (full screen so add a margin)
    return (
      <Surface style={[container, style, ThemeBackColour()]}>
        <SafeAreaView style={safeView}>
          <StatusBar barStyle={DARKMODE ? 'light-content' : 'dark-content'} 
            backgroundColor={ThemeColour()}/>
            { !showPro ? <AdmobBanner /> : null }
            <Surface style={child}>
              { children }
            </Surface>
          { empty ? null : this.renderFooter() }
        </SafeAreaView>
      </Surface>
    )
  };

  renderFooter() {
    const { text, footer } = styles;
    const { title, onPress, about, upper } = this.props;

    let shouldDisable = (!onPress && !about)

    return (
      <View style={[footer, ThemeBackColour()]}>
        { SWAPBUTTON ? this.renderRight() : this.renderLeft() }
        <Button disabled={shouldDisable} onPress={this.pressEvent} style={text} uppercase={upper}>
          { title ? title : this.lucky }
        </Button>
        { SWAPBUTTON ? this.renderLeft() : this.renderRight() }
      </View>
    )
  }

  renderLeft() {
    const { noLeft, home } = this.props;
    return noLeft ? null : <FooterButton icon={home ? 'settings' : 'home'} left={!SWAPBUTTON}/>;
  }

  renderRight() {
    const { noRight, home } = this.props;
    return noRight ? null : <FooterButton icon={home ? 'search' : 'arrow-back'} left={SWAPBUTTON}/>;
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
    flex: 1
  },
  text: {
    fontSize: 17, fontWeight: isAndroid ? 'bold' : '300',
    textAlign: 'center', alignSelf: 'center',
    width: '70%',
  },
  child: {
    flex: 1,
  },
  safeView: {
    flex: 1
  },
  footer: {
    height: 48, 
    justifyContent: 'center',
  }
});

export { WoWsInfo };
