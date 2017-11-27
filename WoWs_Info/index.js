import { AppRegistry } from 'react-native';
import App from './App';
import { DataStorage, GameVersion, StorageManager, DateCalculator } from './src/core/util';
import { localDataName } from './src/constant/value';
import './reactotron';

// Setting up Data here
if (StorageManager.getItem(localDataName.firstLaunch) != null) {
  console.log('First Launch\nWelcome to WoWs Info >_<')
  DataStorage.setupLocalStorage();
}

// Checking for updates
if (GameVersion.hasUpdate()) {
  console.log('Updating data');
}

// A new day?
if (DateCalculator.isNewDay()) {
  console.log('A new day');
  // Update access_token (in the future)
  if (DateCalculator.shouldUpdateToken()) {
    console.log('Update access_token');
  }
}

AppRegistry.registerComponent('WoWs_Info', () => App);
