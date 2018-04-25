import { Navigation } from 'react-native-navigation';

import News from './News';
import Search from './Search';
import Settings from './Settings';
import Drawer from './Drawer';

export function registerScreens() {
  Navigation.registerComponent('info.Drawer', () => Drawer);  
  Navigation.registerComponent('info.News', () => News);
  Navigation.registerComponent('info.Search', () => Search);
  Navigation.registerComponent('info.Settings', () => Settings);
}