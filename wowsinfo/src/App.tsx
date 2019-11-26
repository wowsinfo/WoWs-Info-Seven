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
 import { WoWsComponent } from './ui/component/WoWsComponent';
import DataStorage from './core/util/DataStorage';
import { Button, Text, Surface, DarkTheme } from 'react-native-paper';
import { ThemeConsumer } from './ui/component/ThemeProvider';

export default class App extends Component implements WoWsComponent {
  isProFeature: boolean = false;
  dataStorage = DataStorage.Instance;

  constructor({}) {
    super({});

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

  renderButton() {
    return (
      <ThemeConsumer>
        { context => (
          <Button onPress={() => context!.updateTheme(DarkTheme)}>Theme</Button>
        )}
      </ThemeConsumer>
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
