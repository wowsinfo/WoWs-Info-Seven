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
  }

  async componentWillMount() {
    await DataStorage.restoreTheme();
    // console.log(global.themeColour);
    this.setState({
      isReady: false,
      colour: global.themeColour,
    })

    let ready = await DataStorage.dataValidation();
    this.setState({
      isReady: ready,
      colour: global.themeColour,
    })
  }

  render() {
    if (this.state.isReady) {
      return (
        <View style={ViewStyle}>
          <WoWsStatusBar themeColour={this.state.colour}/>
          <MainRouter reset={this.resetApp}/>
        </View>
      );
    } else {
      // Loading Screen now uses theme colour
      return (
        <LoadingScreen colour={this.state.colour}/>
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
