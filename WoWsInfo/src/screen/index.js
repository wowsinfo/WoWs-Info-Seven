import { Navigation } from 'react-native-navigation';

import News from './News/News';
import More from './News/More';

import Search from './Search';
import Drawer from './Drawer';
import WoWsInfo from './WoWsInfo';

import Settings from './Settings/Settings';
import Theme from './Settings/Theme';

export function registerScreens() {
  Navigation.registerComponent('app.wowsinfo', () => WoWsInfo);    
  Navigation.registerComponent('app.drawer', () => Drawer);  
  Navigation.registerComponent('info.news', () => News);
  Navigation.registerComponent('news.more', () => More);
  Navigation.registerComponent('info.search', () => Search);
  Navigation.registerComponent('info.settings', () => Settings);
  Navigation.registerComponent('settings.theme', () => Theme);
}