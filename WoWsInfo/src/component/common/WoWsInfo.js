import React, { Component } from 'react';
import { SafeAreaView, Text, StyleSheet } from 'react-native';
import lang from '../../value/lang';

class WoWsInfo extends Component {
  constructor(props) {
    super(props);

    const name = [lang.wowsinfo, lang.wowsinfo_black, lang.wowsinfo_go, lang.wowsinfo_infinite,
                 lang.wowsinfo_new, lang.wowsinfo_omega, lang.wowsinfo_phi, lang.wowsinfo_pro,
                 lang.wowsinfo_ultimate, lang.wowsinfo_ultra, lang.wowsinfo_white, lang.wowsinfo_x, 
                 lang.wowsinfo_y, lang.wowsinfo_z];
    // Get a name from used names
    this.lucky = name[Math.floor(Math.random() * name.length)];
  }

  render() {
    const { container, title } = styles;
    return (
      <SafeAreaView style={container}>
        <Text style={title}>{`WoWs Info ${this.lucky}`}</Text>
      </SafeAreaView>
    )
  };
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    alignItems: 'center',
  },
  title: {
    fontSize: 17, fontWeight: '300',
    textAlign: 'center',
    marginBottom: 16
  }
});

export { WoWsInfo };
