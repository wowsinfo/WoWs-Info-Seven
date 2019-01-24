import { GREY, BLUE } from 'react-native-material-color';
import { LOCAL } from './data';
import { SafeStorage, Guard } from '../core';

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

export const TintTextColour = () => {
  let colour = TintColour();
  if (!colour) colour = BLUE;
  return {color: colour[500]};
}

export const UpdateTintColour = (tint) => {
  DATA[LOCAL.theme] = tint;
  SafeStorage.set(LOCAL.theme, tint);
}