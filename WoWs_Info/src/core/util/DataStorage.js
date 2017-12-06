import { Platform } from 'react-native';
import { IOSDataName, localDataName } from '../../constant/value';
import { WoWsInfo } from '../../colour/colour';
import { Language, GameVersion, DateCalculator, PlayerConverter } from './';
import store from 'react-native-simple-store';
import { DataManager } from '../data/';

class DataStorage {
  static async dataValidation() {
    try {
      // Setting up Data here
      let first = await store.get(localDataName.firstLaunch);
      if (first == null) {
        console.log('First Launch\nWelcome to WoWs Info >_<')
        await DataStorage.setupLocalStorage();
        await DataManager.updateLocalData();
      } else {
        // Checking for updates
        let saved = await store.get(localDataName.gameVersion);
        let curr = await GameVersion.getCurrVersion();
        console.log('Game Version\nCurr: ' + curr + '\nSaved: ' + saved);
        if (curr != saved) {
          DataManager.updateLocalData();
          await store.update(localDataName.gameVersion, curr);
        }
  
        let date = await store.get(localDataName.currDate);
        // A new day?
        if (DateCalculator.isNewDay(date)) {
          console.log('Another wonderful day');
          // Update access_token (in the future)
          let token = await store.get(localDataName.tokenDate);
          if (DateCalculator.shouldUpdateToken(token)) {
            console.log('Update access_token');
          }
        }
      }
      return true;
    } catch (error) {
      console.error(error);
      return false;
    }
  }

  static async setupLocalStorage() {
    try {
      await store.update(localDataName.isPro, false);
      await store.update(localDataName.hasAds, true);
      // I am more than happy to play in a division
      await store.update(localDataName.playerList, [{name: 'HenryQuan', id: '2011774448', server: '3'}]);
      await store.update(localDataName.userInfo, {name: '', id: '', server: '', access_token: ''});
      await store.update(localDataName.userData, '');
  
      let version = await GameVersion.getCurrVersion();
      await store.update(localDataName.gameVersion, version);
  
      await store.update(localDataName.currDate, DateCalculator.getCurrDate());
      await store.update(localDataName.tokenDate, '');
      await store.update(localDataName.currServer, '3');
  
      // Theme Red Blue Green
      let currOS = Platform.OS;
      if (currOS == 'ios') {
        await store.update(localDataName.themeColour, WoWsInfo.blue);
      } else if (currOS == 'android') {
        await store.update(localDataName.themeColour, WoWsInfo.red);
      } else {
        await store.update(localDataName.themeColour, WoWsInfo.green);
      }
      await store.update(localDataName.firstLaunch, false);
      await store.update(localDataName.appLanguage, Language.getCurrentLanguage());
      await store.update(localDataName.newsLanguage, Language.getNewsLanguage());
      await store.update(localDataName.apiLanguage, Language.getApiLanguage());
  
      // Check again for userdefault
      if (currOS == 'ios') {
        var UserDefaults = require('react-native-userdefaults-ios');
        let data = await UserDefaults.objectForKey(IOSDataName.firstLaunch);
        if (data != null) {
          console.log('Retrieving userdefault...');
          let server = await UserDefaults.stringForKey(IOSDataName.server);
          await store.update(localDataName.currServer, server);
          
          let pro = await UserDefaults.boolForKey(IOSDataName.hasPurchased);
          await store.update(localDataName.isPro, pro);
          if (pro) await store.update(localDataName.hasAds, false);
          
          let username = await UserDefaults.stringForKey(IOSDataName.userName);
          if (username != '>_<') {
            var playerObj = PlayerConverter.fromString(username);
            playerObj[access_token] = '';
            await store.update(localDataName.userInfo, playerObj);
          }
  
          let friend = await UserDefaults.objectForKey(IOSDataName.friend);
          if (friend != null) {
            var playerList = [];
            for (var i = 0; i < friend.length; i++) {
              playerList.push(PlayerConverter.fromString(friend[i]));
            }
            await store.update(localDataName.playerList, playerList);
          }
        }
      }
    } catch (error) {
      console.error(error);
    }
  }
}

export {DataStorage};