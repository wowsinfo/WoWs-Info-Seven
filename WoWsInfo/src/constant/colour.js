import { GREY } from "react-native-material-color";

/**
 * Get text colour depending on tint colour (white or black)
 * @param {*} colour 
 */
export function getTextColour(colour) {
  // console.log(colour);
  var number = String(colour).replace('#', '');
  // Get red green blue
  let red = parseInt(number.substr(0, 2), 16);
  let green = parseInt(number.substr(2, 2), 16);
  let blue = parseInt(number.substr(4, 2), 16);
  // White or Black
  if (red * 0.299 + green * 0.587 + blue * 0.114 > 186) return '#000000';
  else return '#ffffff'
}

export function statusBarColour(colour) {
  if (getTextColour(colour) == '#000000') return 'dark';
  else return 'light';
}

/**
 * Get global theme colour
 */
export function getTheme() {
  return theme[500] == '#ffffff' ? GREY[800] : theme[500];
}

/**
 * General navigation style
 */
export function navStyle() {
  return {
    navBarTextColor: getTextColour(theme[500]),
    navBarBackgroundColor: theme[500],
    statusBarTextColorScheme: statusBarColour(theme[500]),
    navBarButtonColor: getTextColour(theme[500]),
    statusBarColor: theme[700],
    screenBackgroundColor: '#FEFEFE'
  }
}

/**
 * Personal Rating colours
 */
export const PRColour = {
  ImprovementNeeded: 'red',
  BelowAverage: 'orange',
  Average: '#F5C84C',
  Good: '#67AF34',
  VeryGood: '#4A7D23',
  Great: 'cyan',
  Unicum: 'magenta',
  SuperUnicum: 'purple',
}