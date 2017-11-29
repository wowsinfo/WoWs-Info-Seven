import { AppRegistry } from 'react-native';
import App from './App';
import { DataStorage } from './src/core/util';
import './reactotron';

DataStorage.dataValidation();
AppRegistry.registerComponent('WoWs_Info', () => App);
