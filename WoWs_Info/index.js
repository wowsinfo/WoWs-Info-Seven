import { AppRegistry } from 'react-native';
import App from './App';
import { DataStorage, GameVersion, StorageManager} from './src/core/';
import { localDataName } from './src/constant/value';
import './reactotron';

// Setting up Data here
if (StorageManager.getItem(localDataName.firstLaunch) != null) {
  console.log('First Launch\nWelcome to WoWs Info >_<')
  DataStorage.setupLocalStorage();
}

// Checking for updates
if (GameVersion.hasUpdate) {
  console.log('Updating data');
}

AppRegistry.registerComponent('WoWs_Info', () => App);
