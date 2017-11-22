import { Platform, AsyncStorage } from 'react-native';
import { IOSDataName, localDataName } from '../constant/value';

class DataStorage {
  static setupLocalStorage() {
    try {
      AsyncStorage.setItem(localDataName.isPro, JSON.stringify(false));
      AsyncStorage.setItem(localDataName.hasAds, JSON.stringify(true));
      AsyncStorage.setItem(localDataName.playerList, '');
      AsyncStorage.setItem(localDataName.userInfo, JSON.stringify({name: '', id: '', server: '', access_token: ''}));
      AsyncStorage.setItem(localDataName.userData, '');
      AsyncStorage.setItem(localDataName.gameVersion, '');
      AsyncStorage.setItem(localDataName.currDate, '');
      AsyncStorage.setItem(localDataName.tokenDate, '');
      AsyncStorage.setItem(localDataName.currServer, '3');
      AsyncStorage.setItem(localDataName.themeColour, JSON.stringify({tintColour: '', textColour: '', bgColour: ' '}));
      AsyncStorage.setItem(localDataName.firstLaunch, JSON.stringify(false));
      AsyncStorage.setItem(localDataName.appLanguage, '');

      AsyncStorage.getItem(localDataName.userInfo).then(value => {
        console.log(value);
        var data = JSON.parse(value);
        console.log(data);
      })
    } catch (error) {
      // Something is wrong
      console.log(error);
    }
  }
}

export default DataStorage;