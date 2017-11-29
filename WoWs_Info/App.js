import React, { Component } from 'react';
import { Text, View, StatusBar } from 'react-native';
import { ServerManager, DateCalculator } from './src/core/util';
import strings from './src/localization';

export default class App extends Component {
  render() {
    return (
      <View style={styles.viewStyle}>
        <StatusBar barStyle='light-content'/>
        <Text style={styles.textStyle}>
          {strings.download_data}
        </Text>
      </View>
    );
  }
}

const styles = {
  viewStyle: {
    backgroundColor: 'white',
    flex: 1,
  },
  textStyle: {
    textAlign: 'center',
    padding: 20,
  }
}
