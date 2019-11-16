/**
 * The entry point of this app
 */

import * as React from 'react';
import { AppRegistry } from 'react-native';
import { name as WoWsInfo } from './app.json';
import App from './src/App';
import ThemeProvider from './src/ui/component/ThemeProvider';

export default function Main() {
  return (
    <ThemeProvider>
      <App />
    </ThemeProvider>
  );
};

AppRegistry.registerComponent(WoWsInfo, () => Main);