import { Platform, AsyncStorage } from 'react-native';
import { IOSDataName, localDataName } from '../constant/value';
import { WoWsInfo } from '../colour/colour';
import { Language, GameVersion, DateCalculator } from '../core/';

class DataStorage {
  static setupLocalStorage() {
    try {
      AsyncStorage.setItem(localDataName.isPro, JSON.stringify(false));
      AsyncStorage.setItem(localDataName.hasAds, JSON.stringify(true));
      // I am more than happy to play in a division
      AsyncStorage.setItem(localDataName.playerList, JSON.stringify([{name: 'HenryQuan', id: '2011774448', server: '3'}]));
      AsyncStorage.setItem(localDataName.userInfo, JSON.stringify({name: '', id: '', server: '', access_token: ''}));
      AsyncStorage.setItem(localDataName.userData, '');
      AsyncStorage.setItem(localDataName.gameVersion, GameVersion.updateVersion());
      AsyncStorage.setItem(localDataName.currDate, DateCalculator.getCurrDate());
      AsyncStorage.setItem(localDataName.tokenDate, '');
      AsyncStorage.setItem(localDataName.currServer, '3');

      let currOS = Platform.OS;
      if (currOS == 'ios') {
        AsyncStorage.setItem(localDataName.themeColour, JSON.stringify({tintColour: 'white', textColour: 'white', bgColour: WoWsInfo.blue}));
      } else if (currOS == 'android') {
        AsyncStorage.setItem(localDataName.themeColour, JSON.stringify({tintColour: 'white', textColour: 'white', bgColour: WoWsInfo.red}));
      } else {
        AsyncStorage.setItem(localDataName.themeColour, JSON.stringify({tintColour: 'white', textColour: 'white', bgColour: WoWsInfo.green}));
      }
      AsyncStorage.setItem(localDataName.firstLaunch, JSON.stringify(false));
      AsyncStorage.setItem(localDataName.appLanguage, Language.getCurrentLanguage());

      // Check again for userdefault
      if (currOS == 'ios') {
        
      }
    } catch (error) {
      // Fail to setup some data
      console.error(error);
    }
  }
}

export {DataStorage};