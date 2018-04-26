import { Navigation } from 'react-native-navigation';

import News from './News';
import Search from './Search';
import Settings from './Settings';
import Drawer from './Drawer';

export function registerScreens() {
  Navigation.registerComponent('info.drawer', () => Drawer);  
  Navigation.registerComponent('info.news', () => News);
  Navigation.registerComponent('info.search', () => Search);
  Navigation.registerComponent('info.settings', () => Settings);
}