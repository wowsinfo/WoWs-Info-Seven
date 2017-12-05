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
          store.update(localDataName.gameVersion, curr);
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
    store.update(localDataName.isPro, false);
    store.update(localDataName.hasAds, true);
    // I am more than happy to play in a division
    store.update(localDataName.playerList, [{name: 'HenryQuan', id: '2011774448', server: '3'}]);
    store.update(localDataName.userInfo, {name: '', id: '', server: '', access_token: ''});
    store.update(localDataName.userData, '');
    GameVersion.getCurrVersion().then(version => {
      store.update(localDataName.gameVersion, version);
    })
    store.update(localDataName.currDate, DateCalculator.getCurrDate());
    store.update(localDataName.tokenDate, '');
    store.update(localDataName.currServer, '3');

    let currOS = Platform.OS;
    if (currOS == 'ios') {
      store.update(localDataName.themeColour, WoWsInfo.blue);
    } else if (currOS == 'android') {
      store.update(localDataName.themeColour, WoWsInfo.red);
    } else {
      store.update(localDataName.themeColour, WoWsInfo.green);
    }
    store.update(localDataName.firstLaunch, false);
    store.update(localDataName.appLanguage, Language.getCurrentLanguage());
    store.update(localDataName.newsLanguage, Language.getNewsLanguage());
    store.update(localDataName.apiLanguage, Language.getApiLanguage());

    // Check again for userdefault
    if (currOS == 'ios') {
      var UserDefaults = require('react-native-userdefaults-ios');
      UserDefaults.objectForKey(IOSDataName.firstLaunch).then(data => {
        if (data != null) {
          console.log('Retrieving userdefault...');
          UserDefaults.stringForKey(IOSDataName.server).then(server => {
            store.update(localDataName.currServer, server);
          })
          UserDefaults.boolForKey(IOSDataName.hasPurchased).then(pro => {
            store.update(localDataName.isPro, pro);
            if (pro) store.update(localDataName.hasAds, false);
          })
          UserDefaults.stringForKey(IOSDataName.userName).then(username => {
            if (username != '>_<') {
              var playerObj = PlayerConverter.fromString(username);
              playerObj[access_token] = '';
              store.update(localDataName.userInfo, playerObj);
            }
          })
          UserDefaults.objectForKey(IOSDataName.friend).then(friend => {
            if (friend != null) {
              var playerList = [];
              for (var i = 0; i < friend.length; i++) {
                playerList.push(PlayerConverter.fromString(friend[i]));
              }
              store.update(localDataName.playerList, playerList);
            }
          })
        }
      })
    }
  }
}

export {DataStorage};