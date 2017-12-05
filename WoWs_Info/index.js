import { AppRegistry } from 'react-native';
import App from './src/App';
import { DataStorage } from './src/core/util';
import './reactotron';
import './src/global';

DataStorage.dataValidation();
AppRegistry.registerComponent('WoWs_Info', () => App);
