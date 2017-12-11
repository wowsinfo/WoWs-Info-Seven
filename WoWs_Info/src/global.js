import { Platform } from 'react-native';
import { WoWsInfo } from '../src/colour/colour';

global.server = 3;
global.serverName = 'asia';
global.userInfo = { name: '', id: '', server: '', access_token: '' };
global.isPro = false;
global.hasAds = true;
global.apiLanguage = 'en';
global.appLanguage = 'en';
global.newsLanguage = 'en';
switch (Platform.OS) {
  case 'ios':
    global.themeColor = WoWsInfo.blue; break;
  case 'android':
    global.themeColor = WoWsInfo.red; break;
  case 'windows':
    global.themeColor = WoWsInfo.green; break;
  default: break;
}

global.languageJson = {};
global.achievementJson = {};
global.consumableJson = {};
global.encyclopediaJson = {};
global.warshipJson = {};
global.commanderSkillJson = {};
global.gameMapJson = {};