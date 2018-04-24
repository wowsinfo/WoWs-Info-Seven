import { Navigation } from 'react-native-navigation';

import News from './News';
import Search from './Search';
import Settings from './Settings';

export function registerScreens() {
  Navigation.registerComponent('info.News', () => News);
  Navigation.registerComponent('info.Search', () => Search);
  Navigation.registerComponent('info.Settings', () => Settings);
}