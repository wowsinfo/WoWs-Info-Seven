import { Platform } from 'react-native';
import { IOSDataName, localDataName } from '../../constant/value';
import { WoWsInfo } from '../../colour/colour';
import { Language, GameVersion, DateCalculator, PlayerConverter } from './';
import store from 'react-native-simple-store';
import { DataManager } from '../data/';

class DataStorage {
  static dataValidation() {
    // Setting up Data here
    store.get(localDataName.firstLaunch).then(first => {
      if (first == null) {
        console.log('First Launch\nWelcome to WoWs Info >_<')
        DataStorage.setupLocalStorage();
        DataManager.updateLocalData();
      }
    })

    // Checking for updates
    store.get(localDataName.gameVersion).then(saved => {
      GameVersion.getCurrVersion().then(curr => {
        if (curr != saved) {
          console.log('Game update\nVersion: ' + curr + '\nBefore: ' + saved);
          DataManager.updateLocalData();
          store.set(localDataName.gameVersion, curr);
        }
      });
    })

    store.get(localDataName.currDate).then(date => {
      // A new day?
      if (DateCalculator.isNewDay(date)) {
        console.log('Another wonderful day');
        // Update access_token (in the future)
        store.get(localDataName.tokenDate).then(token => {
          if (DateCalculator.shouldUpdateToken(token)) {
            console.log('Update access_token');
          }
        })
      }
    })
  }

  static setupLocalStorage() {
    store.set(localDataName.isPro, false);
    store.set(localDataName.hasAds, true);
    // I am more than happy to play in a division
    store.set(localDataName.playerList, [{name: 'HenryQuan', id: '2011774448', server: '3'}]);
    store.set(localDataName.userInfo, {name: '', id: '', server: '', access_token: ''});
    store.set(localDataName.userData, '');
    GameVersion.getCurrVersion().then(version => {
      store.set(localDataName.gameVersion, version);
    })
    store.set(localDataName.currDate, DateCalculator.getCurrDate());
    store.set(localDataName.tokenDate, '');
    store.set(localDataName.currServer, '3');

    let currOS = Platform.OS;
    if (currOS == 'ios') {
      store.set(localDataName.themeColour, {tintColour: 'white', textColour: 'white', bgColour: WoWsInfo.blue});
    } else if (currOS == 'android') {
      store.set(localDataName.themeColour, {tintColour: 'white', textColour: 'white', bgColour: WoWsInfo.red});
    } else {
      store.set(localDataName.themeColour, {tintColour: 'white', textColour: 'white', bgColour: WoWsInfo.green});
    }
    store.set(localDataName.firstLaunch, false);
    store.set(localDataName.appLanguage, Language.getCurrentLanguage());
    store.set(localDataName.newsLanguage, Language.getNewsLanguage());
    store.set(localDataName.apiLanguage, Language.getApiLanguage());

    // Check again for userdefault
    if (currOS == 'ios') {
      var UserDefaults = require('react-native-userdefaults-ios');
      UserDefaults.objectForKey(IOSDataName.firstLaunch).then(data => {
        if (data != null) {
          console.log('Retrieving userdefault...');
          UserDefaults.stringForKey(IOSDataName.server).then(server => {
            store.set(localDataName.currServer, server);
          })
          UserDefaults.boolForKey(IOSDataName.hasPurchased).then(pro => {
            store.set(localDataName.isPro, pro);
            if (pro) store.set(localDataName.hasAds, false);
          })
          UserDefaults.stringForKey(IOSDataName.userName).then(username => {
            if (username != '>_<') {
              var playerObj = PlayerConverter.fromString(username);
              playerObj[access_token] = '';
              store.set(localDataName.userInfo, playerObj);
            }
          })
          UserDefaults.objectForKey(IOSDataName.friend).then(friend => {
            if (friend != null) {
              var playerList = [];
              for (var i = 0; i < friend.length; i++) {
                playerList.push(PlayerConverter.fromString(friend[i]));
              }
              store.set(localDataName.playerList, playerList);
            }
          })
        }
      })
    }
  }
}

export {DataStorage};