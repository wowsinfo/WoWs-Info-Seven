// From dropfen 
// https://gist.github.com/dropfen/4a2209d7274788027f782e8655be198f

import FontAwesome from 'react-native-vector-icons/FontAwesome';
import Ionicons from 'react-native-vector-icons/Ionicons';
import Entypo from 'react-native-vector-icons/Entypo';
import MaterialIcons from 'react-native-vector-icons/MaterialIcons'
import { GREY } from 'react-native-material-color';

const replaceSuffixPattern = /--(active|big|small|very-big)/g;
const icons = {
  // Tab
  'newspaper-o': [26, '#fff', FontAwesome],
  'ios-search': [26, GREY[600]],
  'ios-settings': [24, GREY[600]],
  'menu': [26, '#fff', Entypo],
  // Wiki
  'undo': [22, '#fff', FontAwesome],
  'filter': [26, '#fff', FontAwesome],
  'wikipedia-w': [24, GREY[600], FontAwesome],
  // Player
  'star': [24, '#fff', FontAwesome],
  'star-o': [24, '#fff', FontAwesome],  
  // Drawer
  'home': [24, GREY[600], Entypo],  
  'map': [24, GREY[600], Entypo],
  // Settings
  'email': [24, GREY[600], MaterialIcons],
  'color-lens': [24, GREY[600], MaterialIcons],
  'logo-github': [24, GREY[600]],
  'md-git-commit': [24, GREY[600]],
  'md-information-circle': [24, GREY[600]],
}

const defaultIconProvider = Ionicons;

let iconsMap = {};
let iconsLoaded = new Promise((resolve, reject) => {
  new Promise.all(
    Object.keys(icons).map(iconName => {
      const Provider = icons[iconName][2] || defaultIconProvider; // Ionicons
      return Provider.getImageSource(
        iconName.replace(replaceSuffixPattern, ''),
        icons[iconName][0],
        icons[iconName][1]
      )
    })
  ).then(sources => {
    Object.keys(icons)
      .forEach((iconName, idx) => iconsMap[iconName] = sources[idx])
    // Call resolve (and we are done)
    resolve(true);
  })
});

export function getImage(type) {
  let typeJson = data.ship_type;
  switch (typeJson[type]) {
    case typeJson.AirCarrier: return require('../img/AircraftCarrier.png');
    case typeJson.Battleship: return require('../img/Battleship.png');
    case typeJson.Cruiser: return require('../img/Cruiser.png');
    case typeJson.Destroyer: return require('../img/Destroyer.png');
    default: return null;
  }
}

export { iconsMap, iconsLoaded };