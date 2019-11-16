/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 *
 * Generated with the TypeScript template
 * https://github.com/react-native-community/react-native-template-typescript
 *
 * @format
 */

import React from 'react';
import { View, Text } from 'react-native';
import { WoWsComponent, WoWsProps } from './ui/component/WoWsComponent';
import DataStorage from './core/util/DataStorage';

export default class App extends WoWsComponent {
  dataStorage = DataStorage.Instance;

  constructor(props: WoWsProps) {
    super(props);
    this.state = {
      loading: true,
      error: DataStorage.OK
    };

    // Setup the entire app
    this.dataStorage.init().then(msg => {
      this.setState({
        loading: false,
        error: msg
      });
    })
  }

  render() {
    return (
      <View>
        <Text>Hello World</Text>
      </View>
    );
  }
}
