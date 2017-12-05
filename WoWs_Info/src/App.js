import React, { Component } from 'react';
import { Text, View, StatusBar } from 'react-native';
import { restoreData } from './core/util/RestoreData';
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
    if (this.state.isReady) {
      return (
        <View style={styles.viewStyle}>
          <StatusBar barStyle='light-content'/>
          <Text style={styles.textStyle}>
            {global.newsLanguage}
          </Text>
        </View>
      );
    } else {
      return (
        <View style={styles.viewStyle}>
          <StatusBar barStyle='light-content'/>
          <Text style={styles.textStyle}>
            NotReady
          </Text>
        </View>
      );
    }
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
