import { Platform } from 'react-native';
import { IOSDataName, localDataName } from '../../constant/value';
import { WoWsInfo } from '../../colour/colour';
import { Language, GameVersion, DateCalculator, PlayerConverter, StorageManager } from './';
import { DataManager } from '../data/';

class DataStorage {
  static dataValidation() {
    // Setting up Data here
    StorageManager.getItem(localDataName.firstLaunch).then(first => {
      if (first == null) {
        console.log('First Launch\nWelcome to WoWs Info >_<')
        DataStorage.setupLocalStorage();
        DataManager.updateLocalData();
      }
    })

    // Checking for updates
    StorageManager.getItem(localDataName.gameVersion).then(saved => {
      GameVersion.getCurrVersion().then(curr => {
        if (curr != saved) {
          console.log('Game update\nVersion: ' + curr + '\nBefore: ' + saved);
          DataManager.updateLocalData();
          StorageManager.setItem(localDataName.gameVersion, curr);
        }
      });
    })

    StorageManager.getItem(localDataName.currDate).then(date => {
      // A new day?
      if (DateCalculator.isNewDay(date)) {
        console.log('Another wonderful day');
        // Update access_token (in the future)
        StorageManager.getItem(localDataName.tokenDate).then(token => {
          if (DateCalculator.shouldUpdateToken(token)) {
            console.log('Update access_token');
          }
        })
      }
    })
  }

  static setupLocalStorage() {
    StorageManager.setItem(localDataName.isPro, false);
    StorageManager.setItem(localDataName.hasAds, true);
    // I am more than happy to play in a division
    StorageManager.setItem(localDataName.playerList, [{name: 'HenryQuan', id: '2011774448', server: '3'}]);
    StorageManager.setItem(localDataName.userInfo, {name: '', id: '', server: '', access_token: ''});
    StorageManager.setItem(localDataName.userData, '');
    GameVersion.getCurrVersion().then(version => {
      StorageManager.setItem(localDataName.gameVersion, version);
    })
    StorageManager.setItem(localDataName.currDate, DateCalculator.getCurrDate());
    StorageManager.setItem(localDataName.tokenDate, '');
    StorageManager.setItem(localDataName.currServer, '3');

    let currOS = Platform.OS;
    if (currOS == 'ios') {
      StorageManager.setItem(localDataName.themeColour, {tintColour: 'white', textColour: 'white', bgColour: WoWsInfo.blue});
    } else if (currOS == 'android') {
      StorageManager.setItem(localDataName.themeColour, {tintColour: 'white', textColour: 'white', bgColour: WoWsInfo.red});
    } else {
      StorageManager.setItem(localDataName.themeColour, {tintColour: 'white', textColour: 'white', bgColour: WoWsInfo.green});
    }
    StorageManager.setItem(localDataName.firstLaunch, false);
    StorageManager.setItem(localDataName.appLanguage, Language.getCurrentLanguage());
    StorageManager.setItem(localDataName.newsLanguage, Language.getNewsLanguage());
    StorageManager.setItem(localDataName.apiLanguage, Language.getApiLanguage());

    // Check again for userdefault
    if (currOS == 'ios') {
      var UserDefaults = require('react-native-userdefaults-ios');
      UserDefaults.objectForKey(IOSDataName.firstLaunch).then(data => {
        if (data != null) {
          console.log('Retrieving userdefault...');
          UserDefaults.stringForKey(IOSDataName.server).then(server => {
            StorageManager.setItem(localDataName.currServer, server);
          })
          UserDefaults.boolForKey(IOSDataName.hasPurchased).then(pro => {
            StorageManager.setItem(localDataName.isPro, pro);
            if (pro) StorageManager.setItem(localDataName.hasAds, false);
          })
          UserDefaults.stringForKey(IOSDataName.userName).then(username => {
            if (username != '>_<') {
              var playerObj = PlayerConverter.fromString(username);
              playerObj[access_token] = '';
              StorageManager.setItem(localDataName.userInfo, playerObj);
            }
          })
          UserDefaults.objectForKey(IOSDataName.friend).then(friend => {
            if (friend != null) {
              var playerList = [];
              for (var i = 0; i < friend.length; i++) {
                playerList.push(PlayerConverter.fromString(friend[i]));
              }
              StorageManager.setItem(localDataName.playerList, playerList);
            }
          })
        }
      })
    }
  }
}

export {DataStorage};