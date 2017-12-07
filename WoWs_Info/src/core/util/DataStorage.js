import { Platform } from 'react-native';
import { IOSDataName, localDataName, savedDataName } from '../../constant/value';
import { WoWsInfo } from '../../colour/colour';
import { Language, GameVersion, DateCalculator, PlayerConverter, ServerManager } from './';
import store from 'react-native-simple-store';
import { DataManager } from '../data/';

class DataStorage {
  static async dataValidation() {
    try {
      // Setting up Data here
      let first = await store.get(localDataName.firstLaunch);
      if (first != null) {
        console.log('First Launch\nWelcome to WoWs Info >_<')
        await DataStorage.setupLocalStorage();
        await DataStorage.restoreData();
        await DataManager.updateLocalData();
      } else {
        console.log('Welcome back');
        // Checking for updates
        await DataStorage.restoreData();
        let saved = global.gameVersion;
        let curr = await GameVersion.getCurrVersion();
        console.log('Game Version\nCurr: ' + curr + '\nSaved: ' + saved);
        if (curr != saved) {
          await DataManager.updateLocalData();
          await store.update(localDataName.gameVersion, curr);
        } else {
          await DataStorage.restoreSavedData();          
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

      // Remove country code is needed
      let lang = Language.getCurrentLanguage()
      await store.update(localDataName.appLanguage, lang);
      await store.update(localDataName.newsLanguage, lang);
      await store.update(localDataName.apiLanguage, lang);
  
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

  static async restoreData() {
    global.server = await store.get(localDataName.currServer);
    global.serverName = ServerManager.getDomainFrom(global.server);
    global.userInfo = await store.get(localDataName.userInfo);
    global.isPro = await store.get(localDataName.isPro);
    global.hasAds = await store.get(localDataName.hasAds);
    global.apiLanguage = await store.get(localDataName.apiLanguage);
    global.appLanguage = await store.get(localDataName.appLanguage);
    global.newsLanguage = await store.get(localDataName.newsLanguage);
    global.gameVersion = await store.get(localDataName.gameVersion);
    global.themeColour = await store.get(localDataName.themeColour);
  }

  static async restoreSavedData() {
    global.languageJson = await store.get(savedDataName.language);
    global.achivementJson = await store.get(savedDataName.achievement);
    global.consumableJson = await store.get(savedDataName.consumable);
    global.encyclopediaJson = await store.get(savedDataName.encyclopedia);
    global.warshipJson = await store.get(savedDataName.warship);
    global.commanderSkillJson = await store.get(savedDataName.commanderSkill);
    global.gameMapJson = await store.get(savedDataName.gameMap);
  }
}

export {DataStorage};