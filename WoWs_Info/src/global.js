import { Platform } from 'react-native';
import { WoWsInfo } from '../src/colour/colour';

global.server = 3;
global.serverName = 'asia';
global.userInfo = {name: '', id: '', server: '', access_token: ''};
global.playerList = {};
global.isPro = false;
global.hasAds = true;
global.apiLanguage = 'en';
global.appLanguage = 'en';
global.newsLanguage = 'en';
// Just to prevent user resetting his/her app like crazy
global.canReset = true;
// Prevent show main account when theme or reset and other stuff
global.showMainAccount = true;
switch (Platform.OS) {
  case 'ios':
    global.themeColour = WoWsInfo.blue; break;
  case 'android':
    global.themeColour = WoWsInfo.red; break;
  case 'windows':
    global.themeColour = WoWsInfo.green; break;
  default: break;
}

global.firstLaunch = true;
global.wikiAction = [];

global.languageJson = {};
global.achievementJson = {};
global.consumableJson = {};
global.encyclopediaJson = {};
global.collectionJson = {};
global.collectionItemJson = {};
global.shipTypeJson = {};
global.warshipJson = {};
global.commanderSkillJson = {};
global.gameMapJson = {};
global.personalRatingJson = {};