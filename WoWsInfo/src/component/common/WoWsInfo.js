/*
 * WoWsInfo.js
 *
 * This is used as a footer if no name is passed, it is a about button
 */

import React, { Component } from 'react';
import { SafeAreaView, StyleSheet } from 'react-native';
import { Button, Surface } from 'react-native-paper';
import { isAndroid } from 'react-native-device-detection';
import lang from '../../value/lang';
import { Actions } from 'react-native-router-flux';
import { BackButton } from './BackButton';

class WoWsInfo extends Component {
  constructor(props) {
    super(props);

    const name = [lang.wowsinfo, lang.wowsinfo_black, lang.wowsinfo_go, lang.wowsinfo_new, 
                 lang.wowsinfo_pro, lang.wowsinfo_ultimate, lang.wowsinfo_ultra, lang.wowsinfo_white, 
                 lang.wowsinfo_x, lang.wowsinfo_y, lang.wowsinfo_z, '>_<', '#', 
                 '0_0', '^_^', '★', 'α', 'θ', 'Ω', 'Ф', '∞', '░', '( ͡° ͜ʖ ͡°)', '¯\_(ツ)_/¯',
                 '2018', '?', '!', '2017', '2016'];
    // Get a name from used names
    this.lucky = name[Math.floor(Math.random() * name.length)];
  }

  render() {
    const { container, text } = styles;
    const { children, title, noBack, style } = this.props;
    return (
      <Surface style={[container, style]}>
        <SafeAreaView style={container}>
          <Surface style={container}>
            { children }
          </Surface>
          { noBack ? null : <BackButton /> }
          <Button onPress={this.pressEvent} style={text}>
            { title ? title : `WoWs Info ${this.lucky}`}
          </Button>
        </SafeAreaView>
      </Surface>
    )
  };

  /**
   * Handle press event, dont always go to about page
   */
  pressEvent = () => {
    const { onPress, about } = this.props;
    if (onPress) return onPress();
    else if (about) return this.navigate();
    else return null;
  }

  /**
   * Navigate to About page
   */
  navigate() {
    if (Actions.currentScene !== 'About') {
      // Add guard so that it wont push twice]
      Actions.About();
    }
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
    marginBottom: 4
  }
});

export { WoWsInfo };
