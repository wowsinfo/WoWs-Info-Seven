import { Platform } from 'react-native';
import { BLUE } from 'react-native-material-color';

global.android = Platform.OS == 'android';
global.first_launch = true;
global.ads = true;
global.data_saver = false;
global.api_update = true;

global.theme = BLUE;
global.server = 3;
global.domain = 'asia';
global.api_language = 'en';
global.news_language = 'en';
global.game_version = '';
global.friend = [];
global.user_info = {};
global.user_data = {};
global.saved_tab = 0;

global.rslist = [];

// JSON data
global.data = {
  achievement: {},
  commander: {},
  consumable: {},
  ship_type: {},
  language: {},
  warship: {},
  map: {},
  encyclopedia: {},
  collection: {},
  collection_item: {},
  personal_rating: {}  
}