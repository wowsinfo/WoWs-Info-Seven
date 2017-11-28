import { Platform, AsyncStorage } from 'react-native';
import { IOSDataName, localDataName } from '../../constant/value';
import { WoWsInfo } from '../../colour/colour';
import { Language, GameVersion, DateCalculator, PlayerConverter } from './';

class DataStorage {
  static async setupLocalStorage() {
    try {
      await AsyncStorage.setItem(localDataName.isPro, JSON.stringify(false));
      await AsyncStorage.setItem(localDataName.hasAds, JSON.stringify(true));
      // I am more than happy to play in a division
      await AsyncStorage.setItem(localDataName.playerList, JSON.stringify([{name: 'HenryQuan', id: '2011774448', server: '3'}]));
      await AsyncStorage.setItem(localDataName.userInfo, JSON.stringify({name: '', id: '', server: '', access_token: ''}));
      await AsyncStorage.setItem(localDataName.userData, '');
      await AsyncStorage.setItem(localDataName.gameVersion, GameVersion.updateVersion());
      await AsyncStorage.setItem(localDataName.currDate, DateCalculator.getCurrDate());
      await AsyncStorage.setItem(localDataName.tokenDate, '');
      await AsyncStorage.setItem(localDataName.currServer, '3');

      let currOS = Platform.OS;
      if (currOS == 'ios') {
        await AsyncStorage.setItem(localDataName.themeColour, JSON.stringify({tintColour: 'white', textColour: 'white', bgColour: WoWsInfo.blue}));
      } else if (currOS == 'android') {
        await AsyncStorage.setItem(localDataName.themeColour, JSON.stringify({tintColour: 'white', textColour: 'white', bgColour: WoWsInfo.red}));
      } else {
        await AsyncStorage.setItem(localDataName.themeColour, JSON.stringify({tintColour: 'white', textColour: 'white', bgColour: WoWsInfo.green}));
      }
      await AsyncStorage.setItem(localDataName.firstLaunch, JSON.stringify(false));
      await AsyncStorage.setItem(localDataName.appLanguage, Language.getCurrentLanguage());
      await AsyncStorage.setItem(localDataName.newsLanguage, Language.getNewsLanguage());
      await AsyncStorage.setItem(localDataName.apiLanguage, Language.getApiLanguage());

      // Check again for userdefault
      if (currOS == 'ios') {
        var UserDefaults = require('react-native-userdefaults-ios');
        UserDefaults.objectForKey(IOSDataName.firstLaunch).then(data => {
          if (data != null) {
            console.log('Retrieving userdefault...');
            UserDefaults.stringForKey(IOSDataName.server).then(server => {
              AsyncStorage.setItem(localDataName.currServer, server);
            })
            UserDefaults.boolForKey(IOSDataName.hasPurchased).then(pro => {
              AsyncStorage.setItem(localDataName.isPro, JSON.stringify(pro));
              if (pro) AsyncStorage.setItem(localDataName.hasAds, JSON.stringify(false));
            })
            UserDefaults.stringForKey(IOSDataName.userName).then(username => {
              if (username != '>_<') {
                var playerObj = PlayerConverter.fromString(username);
                playerObj[access_token] = '';
                AsyncStorage.setItem(localDataName.userInfo, JSON.stringify(playerObj));
              }
            })
            UserDefaults.objectForKey(IOSDataName.friend).then(friend => {
              if (friend != null) {
                var playerList = [];
                for (var i = 0; i < friend.length; i++) {
                  playerList.push(PlayerConverter.fromString(friend[i]));
                }
                AsyncStorage.setItem(localDataName.playerList, JSON.stringify(playerList));
              }
            })
          }
        })
      }
    } catch (error) {
      // Fail to setup some data
      console.error(error);
    }
  }
}

export {DataStorage};