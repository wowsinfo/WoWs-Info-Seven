/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 *
 * Generated with the TypeScript template
 * https://github.com/react-native-community/react-native-template-typescript
 *
 * @format
 */

import React, { Component } from 'react';
 import { WoWsComponent, WoWsState } from './ui/component/WoWsComponent';
import DataStorage from './core/util/DataStorage';
import { Button, Text, Surface, DarkTheme, Theme, DefaultTheme } from 'react-native-paper';
import { ConsumerForAll } from './ui/component/ProviderForAll';
import CustomTheme from './core/model/CustomTheme';

export interface AppState extends WoWsState {
  theme: Theme
}

export default class App extends Component<{}, AppState> implements WoWsComponent {
  isProFeature: boolean = false;
  dataStorage = DataStorage.Instance;

  constructor({}) {
    super({});

    this.state = {
      loading: true,
      error: DataStorage.OK,
      theme: DefaultTheme
    };
    
    // Setup the entire app
    this.dataStorage.init().then(msg => {
      this.setState({
        loading: false,
        error: msg
      });
    })
  }

  renderButton() {
    let randomColour = '#'+(0x1000000+(Math.random())*0xffffff).toString(16).substr(1,6);
    let darkTheme = Math.random() * 10 < 5 ? true : false;
    let myTheme = new CustomTheme(darkTheme, randomColour);

    return (
      <ConsumerForAll>
        { context => (
          <Button onPress={() => {
            context!.updateTheme(myTheme.getTheme())
            this.setState({
              theme: myTheme.getTheme()
            })
          }}>Theme</Button>
        )}
      </ConsumerForAll>
    )
  }
  
  render() {
    return (
      <Surface style={{flex: 1, justifyContent: 'center', alignItems: 'center'}}>
        <Text>Hello World</Text>
        { this.renderButton() }
      </Surface>
    );
  }
}
