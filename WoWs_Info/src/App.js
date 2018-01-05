import React, { Component } from 'react';
import { Text, View, StyleSheet } from 'react-native';
import { DataStorage } from './core/';
import { LoadingScreen } from './screen';
import { WoWsStatusBar } from './component/';
import { MainRouter } from './router';
import strings from './localization';

export default class App extends Component {
  state = {
    isReady: false,
    isPro: false,
    hasAds: true,
  }

  async componentWillMount() {
    await DataStorage.restoreTheme();
    await DataStorage.restorePlayerInfo();    
    // console.log(global.themeColour, global.isPro);
    this.setState({
      isPro: global.isPro,
      hasAds: global.hasAds,
      colour: global.themeColour,      
    })

    let ready = await DataStorage.dataValidation();
    this.setState({
      isReady: ready,
    })
  }

  render() {
    const { isReady, colour, isPro, hasAds } = this.state;
    if (isReady) {
      return (
        <View style={ViewStyle}>
          <WoWsStatusBar themeColour={colour}/>
          <MainRouter reset={this.resetApp}/>
        </View>
      );
    } else {
      return (
        <View style={ViewStyle}>
          <WoWsStatusBar themeColour={colour}/>
          <LoadingScreen colour={colour} isPro={isPro} hasAds={hasAds}/>
        </View>
      )
    }
  }

  resetApp = (colour) => {
    this.setState({
      colour: colour,
    })
  }
}

const styles = StyleSheet.create({
  ViewStyle: {
    backgroundColor: 'white',
    flex: 1,
  },
  TextStyle: {
    textAlign: 'center',
    padding: 20,
  }
});

const { ViewStyle, TextStyle } = styles;
