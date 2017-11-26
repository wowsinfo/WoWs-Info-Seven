import { Platform } from 'react-native';

export const WoWsInfo = {
  red: '#FF6D6B',
  green: '#2CCC72',
  blue: '#55A3FF',
  cyan: '#2DFFE!',
  purple: '#6464C8',
  brown: '#AB7754',
  yellow: '#FFDC64',
  orange: '#FA963C',
  black: '#39393E',
}

export var Theme = {
  textColour: 'white',
  tintColour: 'white',
  ...Platform.select({
    ios: {
      bgColour: WoWsInfo.blue,
    },
    android: {
      bgColour: WoWsInfo.red,
    },
    windows: {
      bgColour: WoWsInfo.green,
    },
  }),
}