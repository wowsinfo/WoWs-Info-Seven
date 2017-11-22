import { AppRegistry } from 'react-native';
import App from './App';
import DataStorage from './src/core/DataStorage';

// Setting up Data here
DataStorage.setupLocalStorage();

AppRegistry.registerComponent('WoWs_Info', () => App);