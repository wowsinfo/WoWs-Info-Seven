
import * as React from 'react';
import { AppRegistry } from 'react-native';
import App from './src/app';
import { Provider as PaperProvider, DefaultTheme } from 'react-native-paper';
import './src/value/global';

export function Main() {
  return (
    <PaperProvider theme={DefaultTheme}>
      <App />
    </PaperProvider>
  );
}

AppRegistry.registerComponent('WoWsInfoMac', () => Main);