import React, { Component } from 'react';
import { Text, View, StyleSheet } from 'react-native';
import { restoreData } from './core/util/RestoreData';
import { LoadingScreen } from './screen';
import { WoWsStatusBar } from './component/common';
import strings from './localization';

export default class App extends Component {
  state = {
    isReady: false,
  }
  
  async componentWillMount() {
    let ready = await restoreData();
    this.setState({
      isReady: ready,
    })
  }

  render() {
    if (!this.state.isReady) {
      return (
        <View style={ViewStyle}>
          <WoWsStatusBar />
          <Text style={TextStyle}>
            Ready
          </Text>
        </View>
      );
    } else {
      return <LoadingScreen />
    }
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
