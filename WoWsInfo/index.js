/** @format */

import * as React from 'react';
import { AppRegistry } from 'react-native';
import App from './src/app';
import { DefaultTheme, DarkTheme, Provider as PaperProvider, Colors } from 'react-native-paper';
import { name as appName } from './app.json';
import { Menu } from './src/page';

const Light = {
  ...DefaultTheme,
  roundness: 8,
  colors: {
    ...DefaultTheme.colors,
    primary: Colors.blue500,
    accent: Colors.blue300,
  }
};

const Dark = {
  ...DarkTheme,
  roundness: 8,
  colors: {
    ...DarkTheme.colors,
    surface: Colors.grey800,
    primary: Colors.blue500,
    accent: Colors.blue300,
  }
};

export default function Main() {
  return (
    <PaperProvider theme={Light}>
      <Menu />
    </PaperProvider>
  );
}

AppRegistry.registerComponent(appName, () => Main);