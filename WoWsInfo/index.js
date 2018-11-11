/** @format */

import * as React from 'react';
import { AppRegistry } from 'react-native';
import App from './src/app';
import { DefaultTheme, Provider as PaperProvider } from 'react-native-paper';
import { name as appName } from './app.json';
import { Menu } from './src/page';

const theme = {
  ...DefaultTheme,
  colors: {
    ...DefaultTheme.colors,
    primary: 'tomato',
    accent: 'yellow',
  },
};

export default function Main() {
  return (
    <PaperProvider>
      <Menu />
    </PaperProvider>
  );
}

AppRegistry.registerComponent(appName, () => Main);