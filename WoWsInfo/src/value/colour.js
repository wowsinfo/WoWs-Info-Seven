import { GREY } from 'react-native-material-color';
import { LOCAL } from './data';

export const ThemeBackColour = () => {
  return {backgroundColor: DARKMODE ? GREY[900] : GREY[100]};
}

export const ThemeColour = () => {
  return DARKMODE ? GREY[900] : GREY[100];
}

export const TintColour = () => {
  return DATA[LOCAL.theme];
}