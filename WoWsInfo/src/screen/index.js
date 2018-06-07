import { Navigation } from 'react-native-navigation';

import News from './News/News';
import More from './News/More';
import Browser from './News/Browser';

import Search from './Search';
import Drawer from './Drawer';
import WoWsInfo from './WoWsInfo';

// Wiki
import Wiki from './Wiki/Wiki';
export * from './Wiki/Achievement';
import BasicWiki from './Wiki/BasicWiki';
import BasicDetail from './Wiki/BasicDetail';
import Collection from './Wiki/Collection';
import MapDetail from './Wiki/MapDetail';
import GameMap from './Wiki/GameMap';
import Ship from './Wiki/Ship';
import ShipFilter from './Wiki/ShipFilter';
import ShipDetail from './Wiki/ShipDetail';

// Settings
import Settings from './Settings/Settings';
import Theme from './Settings/Theme';
import PlayerTab from './Player/Player';
import Clan from './Player/Clan';
import PlayerShipDetail from './Player/PlayerShipDetail';
import { PlayerShip } from './Player/PlayerShip';
import OpenSource from './Settings/OpenSource';
import About from './Settings/About';

export function registerScreens() {
  Navigation.registerComponent('app.wowsinfo', () => WoWsInfo);    
  Navigation.registerComponent('app.drawer', () => Drawer);  
  Navigation.registerComponent('info.news', () => News);
  Navigation.registerComponent('info.browser', () => Browser);
  Navigation.registerComponent('news.more', () => More);
  Navigation.registerComponent('info.search', () => Search);
  Navigation.registerComponent('search.player', () => PlayerTab);
  Navigation.registerComponent('player.ship', () => PlayerShipDetail);
  Navigation.registerComponent('rank.ship', () => PlayerShip);
  Navigation.registerComponent('search.clan', () => Clan);
  Navigation.registerComponent('info.wiki', () => Wiki);
  Navigation.registerComponent('wiki.basic', () => BasicWiki);
  Navigation.registerComponent('wiki.collection', () => Collection);
  Navigation.registerComponent('wiki.map', () => GameMap);
  Navigation.registerComponent('map.detail', () => MapDetail);
  Navigation.registerComponent('wiki.ship', () => Ship);  
  Navigation.registerComponent('ship.filter', () => ShipFilter);  
  Navigation.registerComponent('ship.detail', () => ShipDetail);  
  Navigation.registerComponent('basic.detail', () => BasicDetail);
  Navigation.registerComponent('info.settings', () => Settings);
  Navigation.registerComponent('settings.theme', () => Theme);
  Navigation.registerComponent('settings.opensource', () => OpenSource);
  Navigation.registerComponent('info.about', () => About);
}