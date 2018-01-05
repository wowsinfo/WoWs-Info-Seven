import { Platform, Alert } from 'react-native';
import { IOSDataName, localDataName, savedDataName } from '../../constant/value';
import { WoWsInfo } from '../../colour/colour';
import { Language, GameVersion, DateCalculator, PlayerConverter, ServerManager } from '../';
import store from 'react-native-simple-store';
import strings from '../../localization';
import { DataManager } from '../';

class DataStorage {
  static async dataValidation() {
    try {
      // Setting up Data here      
      let first = await store.get(localDataName.firstLaunch);
      if (first == null) {
        console.log('First Launch\nWelcome to WoWs Info >_<');
        await DataStorage.setupLocalStorage();
        await DataStorage.restoreData();
        await DataManager.updateLocalData();
        // Set language here
        strings.setLanguage(Language.getCurrentLanguage());
      } else {
        global.firstLaunch = false;
        console.log('Welcome back');
        // Checking for updates
        await DataStorage.restoreData();
        // Set language here
        strings.setLanguage(Language.getCurrentLanguage());
        let saved = global.gameVersion;
        let curr = await GameVersion.getCurrVersion();
        console.log('Game Version\nCurr: ' + curr + '\nSaved: ' + saved);
        if (curr != saved) {
          // There is an update
          Alert.alert(curr, strings.game_has_update);
          await DataManager.updateLocalData();
          await store.save(localDataName.gameVersion, curr);
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
      // I am more than happy to play in a division
      await store.save(localDataName.playerList, {'2011774448': {name: 'HenryQuan', id: '2011774448', server: '3'}});
      await store.save(localDataName.userInfo, {name: '', id: '', server: '', access_token: '', created_at: ''});
      await store.save(localDataName.userData, '');
  
      let version = await GameVersion.getCurrVersion();
      await store.save(localDataName.gameVersion, version);
  
      await store.save(localDataName.currDate, DateCalculator.getCurrDate());
      await store.save(localDataName.tokenDate, '');
      await store.save(localDataName.currServer, '3');
  
      await DataStorage.setupTheme();
      await store.save(localDataName.firstLaunch, false);

      await store.save(localDataName.isPro, false);
      await store.save(localDataName.hasAds, true);
      await store.save(localDataName.moeMode, false);

      // Remove country code is needed
      let lang = Language.getCurrentLanguage();
      await store.save(localDataName.appLanguage, lang);
      // This is the cause of the mystery
      if (lang == 'zh') lang = 'zh-cn';
      await store.save(localDataName.newsLanguage, lang);
      await store.save(localDataName.apiLanguage, lang);
  
      // Check again for userdefault
      let currOS = Platform.OS;
      if (currOS == 'ios') {
        var UserDefaults = require('react-native-userdefaults-ios');
        let data = await UserDefaults.objectForKey(IOSDataName.firstLaunch);
        if (data != null) {
          console.log('Retrieving userdefault...');
          let server = await UserDefaults.stringForKey(IOSDataName.server);
          await store.save(localDataName.currServer, server);
          
          let pro = await UserDefaults.objectForKey(IOSDataName.hasPurchased);     
          if (pro) {
            await store.save(localDataName.isPro, true);
            await store.save(localDataName.hasAds, false);  
          }
          
          let username = await UserDefaults.stringForKey(IOSDataName.userName);       
          if (username != '>_<') {
            var playerObj = PlayerConverter.fromString(username);
            playerObj.access_token = '';
            playerObj.created_at = '';
            await store.save(localDataName.userInfo, playerObj);
          }
  
          let friend = await UserDefaults.objectForKey(IOSDataName.friend);
          if (friend != null) {
            var playerList = [];
            for (var i = 0; i < friend.length; i++) {
              playerList.push(PlayerConverter.fromString(friend[i]));
            }
            global.playerList = playerList;
            await store.save(localDataName.playerList, playerList);
          }
        }
      } else if (currOS == 'windows') {
        // All UWP are paid so they are all pro users
        await store.save(localDataName.isPro, true);
        await store.save(localDataName.hasAds, false);
      } else if (currOS == 'android') {
        // All Android are plus so they are all pro users but with ads
        await store.save(localDataName.isPro, true);
        await store.save(localDataName.hasAds, true);
      }
    } catch (error) {
      console.error(error);
    }
  }

  static async setupTheme() {
    // Theme Red Blue Green
    var colour = WoWsInfo.blue;
    switch (Platform.OS) {
      case 'android': colour = WoWsInfo.red; break
      case 'windows': colour = WoWsInfo.green; break;
      default: break;
    }
    global.themeColour = colour;
    await store.save(localDataName.themeColour, colour);
  }

  static async restoreTheme() {
    global.themeColour = await store.get(localDataName.themeColour); 
    if (global.themeColour == null) {
      await DataStorage.setupTheme();
    }
  }

  static async restorePlayerInfo() {
    global.isPro = await store.get(localDataName.isPro);
    global.hasAds = await store.get(localDataName.hasAds);
    global.userInfo = await store.get(localDataName.userInfo);   
  }

  static async restoreData() {
    global.themeColour = await store.get(localDataName.themeColour);    
    global.server = await store.get(localDataName.currServer);
    global.serverName = ServerManager.getDomainFrom(global.server);
    global.apiLanguage = await store.get(localDataName.apiLanguage);
    global.appLanguage = await store.get(localDataName.appLanguage);
    global.newsLanguage = await store.get(localDataName.newsLanguage);
    global.gameVersion = await store.get(localDataName.gameVersion);
    global.playerList = await store.get(localDataName.playerList);
    DataStorage.restorePlayerInfo();
  }

  static async restoreSavedData() {
    global.languageJson = await store.get(savedDataName.language);
    global.achievementJson = await store.get(savedDataName.achievement);
    global.consumableJson = await store.get(savedDataName.consumable);
    global.encyclopediaJson = await store.get(savedDataName.encyclopedia);
    global.collectionJson = await store.get(savedDataName.collection);
    global.collectionItemJson = await store.get(savedDataName.collectionItem);
    global.shipTypeJson = await store.get(savedDataName.shipType);
    global.warshipJson = await store.get(savedDataName.warship);
    global.commanderSkillJson = await store.get(savedDataName.commanderSkill);
    global.gameMapJson = await store.get(savedDataName.gameMap);
    global.personalRatingJson = await store.get(savedDataName.personalRating);
    console.log(global.languageJson, global.achievementJson, global.consumableJson, 
      global.encyclopediaJson, global.warshipJson, global.commanderSkillJson, 
      global.gameMapJson, global.personalRatingJson, global.shipTypeJson, global.collectionJson, global.collectionItemJson);
  }
}

export {DataStorage};