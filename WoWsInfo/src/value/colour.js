import { GREY } from 'react-native-material-color';
import { DarkTheme, DefaultTheme } from 'react-native-paper';
import { LOCAL } from './data';
import { SafeStorage } from '../core';

export const ThemeBackColour = () => {
  return {backgroundColor: DARKMODE ? GREY[900] : GREY[100]};
}

export const ThemeColour = () => {
  return DARKMODE ? GREY[900] : GREY[100];
}

export const UpdateDarkMode = () => {
  global.DARKMODE = !DARKMODE;
  SafeStorage.set(LOCAL.darkMode, DARKMODE);
}

export const TintColour = () => {
  return DATA[LOCAL.theme];
}

export const UpdateTintColour = (tint) => {
  DATA[LOCAL.theme] = tint;
  SafeStorage.set(LOCAL.theme, tint);

  // Setup global dark theme
  global.DARK = {
    colors: {
      ...DarkTheme.colors,
      surface: 'black',
      text: GREY[50],
      primary: tint[500],
      accent: tint[500],
    }
  };

  // Setup global light theme
  global.LIGHT = {
    colors: {
      ...DefaultTheme.colors,
      primary: tint[500],
      accent: tint[500],
    }
  };
}