/**
 * The entry point of this app
 */

import React, { Component } from 'react';
import { DefaultTheme, Provider as PaperProvider } from 'react-native-paper';
import { AppRegistry } from 'react-native';
import { name as WoWsInfo } from './app.json';
import App from './src/App';

const theme = {
  ...DefaultTheme,
  colors: {
    ...DefaultTheme.colors,
    primary: 'tomato',
    accent: 'yellow',
  },
};

class Main extends Component {
  render() {
    return (
      <PaperProvider theme={theme}>
        <App />
      </PaperProvider>
    );
  }
}

AppRegistry.registerComponent(WoWsInfo, () => Main);