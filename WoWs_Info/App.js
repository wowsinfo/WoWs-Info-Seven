import React, { Component } from 'react';
import { Text, View, StatusBar } from 'react-native';

export default class App extends Component {
  render() {
    return (
      <View style={styles.viewStyle}>
        <StatusBar barStyle='light-content' backgroundColor={Theme.bgColour}/>
        <Text style={styles.textStyle}>
          Hello World
        </Text>
      </View>
    );
  }
}

const styles = {
  viewStyle: {
    backgroundColor: Theme.bgColour,
    flex: 1,
  },
  textStyle: {
    textAlign: 'center',
    padding: 20,
  }
}
