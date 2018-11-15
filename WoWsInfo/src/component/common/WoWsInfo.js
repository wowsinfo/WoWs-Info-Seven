import React, { Component } from 'react';
import { SafeAreaView, Text, StyleSheet } from 'react-native';
import { Button } from 'react-native-paper';
import { isAndroid } from 'react-native-device-detection';
import lang from '../../value/lang';
import { Actions } from 'react-native-router-flux';

class WoWsInfo extends Component {
  constructor(props) {
    super(props);

    const name = [lang.wowsinfo, lang.wowsinfo_black, lang.wowsinfo_go, lang.wowsinfo_new, 
                 lang.wowsinfo_pro, lang.wowsinfo_ultimate, lang.wowsinfo_ultra, lang.wowsinfo_white, 
                 lang.wowsinfo_x, lang.wowsinfo_y, lang.wowsinfo_z, '>_<', '#', 
                 '0_0', '^_^', '★', 'α', 'θ', 'Ω', 'Ф', '∞', '░', '( ͡° ͜ʖ ͡°)', '¯\_(ツ)_/¯'];
    // Get a name from used names
    this.lucky = name[Math.floor(Math.random() * name.length)];
  }

  render() {
    const { container, title } = styles;
    return (
      <SafeAreaView style={container}>
        <Button onPress={() => this.navigate()} style={title}>{`WoWs Info ${this.lucky}`}</Button>
      </SafeAreaView>
    )
  };

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
    alignItems: 'center',
  },
  title: {
    fontSize: 17, fontWeight: isAndroid ? 'bold' : '300',
    textAlign: 'center',
    marginBottom: 8
  }
});

export { WoWsInfo };
