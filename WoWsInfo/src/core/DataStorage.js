import { Platform, Alert } from 'react-native';
import { IOSData, LocalData, SavedData, VERSION } from '../constant/value';
import { BLUE } from 'react-native-material-color';
import { AdMobInterstitial } from 'react-native-admob';
import { Language, GameVersion, DateCalculator, PlayerConverter, ServerManager } from './';
import store from 'react-native-simple-store';
import { DataManager } from './';
import language from '../constant/language';

class DataStorage {
  static async DataValidation(updateText) {
    try {
      // Setting up Data here      
      let first = await store.get(LocalData.first_launch);
     
      if (first == null) {
        global.first_launch = true;     
        updateText(language.loading_welcome);
        await DataStorage.SetupAllData(updateText);
      } else {
        updateText(language.loading_welcome_back);        
        global.first_launch = false; 
        // Check for App Update
        let appVersion = await store.get(LocalData.curr_version);
        if (appVersion != VERSION) await this.SetupAdditionalData(updateText);

        // Restore essential loca data
        await DataStorage.RestoreData();
        let saved = global.game_version;
        updateText(language.loading_check_update);        
        let curr = await GameVersion.getCurrVersion();
        console.log('Game Version\nCurr: ' + curr + '\nSaved: ' + saved);
        if (curr != saved) {
          updateText(saved + ' -> ' + curr);
          // Update game version
          global.game_version = curr;
          await DataManager.UpdateLocalData(updateText);
          await store.save(LocalData.game_version, curr);
        } else {
          // 2% to update personal rating
          if (Math.floor(Math.random() * 50) == 0) {
            updateText(language.loading_pr);
            await DataManager.savePersonalRating();
          }
          updateText(language.loading_ready);           
          await DataStorage.RestoreSavedData();
        }
  
        let date = await store.get(LocalData.date);
        // A new day?
        if (DateCalculator.isNewDay(date)) {
          console.log('A new day...');
        }
      }
    } catch (error) {
      console.error(error);
    }
  }

  //
  // Setup data
  //

  static async SetupAllData(updateText) {
    await DataStorage.SetupLocalStorage();
    await DataStorage.RestoreData();
    await DataManager.UpdateLocalData(updateText);
  }

  static async SetupAdditionalData(updateText) {
    // Update wows info version
    await store.save(LocalData.curr_version, VERSION);
    // Update everything when software updates occurs
    await DataManager.UpdateLocalData(updateText);
  }

  static async SetupLocalStorage() {
    try {   
      console.log('Local Storage');

      // Change this before version update
      await store.save(LocalData.curr_version, VERSION);

      await store.save(LocalData.friend, []);
      await store.save(LocalData.user_info, {name: '', id: '', server: ''});
      await store.save(LocalData.userdata, {});

      let version = await GameVersion.getCurrVersion();
      await store.save(LocalData.game_version, version);
      let currDate = DateCalculator.getCurrDate()
      await store.save(LocalData.date, currDate);
      await store.save(LocalData.last_update, currDate);
      await store.save(LocalData.server, 3);
      await DataStorage.SetupTheme();
      await store.save(LocalData.has_ads, true);
      await store.save(LocalData.data_saver, false);
      await store.save(LocalData.saved_tab, 0);

      let lang = Language.getCurrentLanguage();
      await store.save(LocalData.api_language, lang);
      await store.save(LocalData.news_language, lang);
      // Check for userdefault ios
      if (Platform.OS == 'ios') await DataStorage.SetupIOSData(); 
      // Finish setup
      await store.save(LocalData.first_launch, false);
    } catch (error) {
      console.error(error);
    }
  }

  static async SetupIOSData() {
    var UserDefaults = require('react-native-userdefaults-ios');
    let data = await UserDefaults.objectForKey(IOSData.first_launch);
    if (data != null) {
      console.log('Retrieving userdefault...');
      let server = await UserDefaults.stringForKey(IOSData.server);
      await store.save(LocalData.server, server);
      
      let pro = await UserDefaults.objectForKey(IOSData.has_purchased);     
      if (pro) await store.save(LocalData.has_ads, false);
      
      let username = await UserDefaults.stringForKey(IOSData.username);       
      if (username != '>_<') {
        var playerObj = PlayerConverter.fromString(username);
        playerObj.access_token = '';
        playerObj.created_at = '';
        await store.save(LocalData.user_info, playerObj);
      }

      let friend = await UserDefaults.objectForKey(IOSData.friend);
      if (friend != null) {
        var playerList = [];
        for (var i = 0; i < friend.length; i++) {
          let obj = PlayerConverter.fromString(friend[i]);
          playerList.push(obj);
        }
        global.friend = playerList;
        await store.save(LocalData.friend, playerList);
      }
    }
  }

  static async SetupTheme() {
    // Theme Red Blue Green
    global.theme = BLUE;
    await store.save(LocalData.theme, BLUE);
  }

  //
  // Restore data section
  //

  static async RestoreTheme() {
    global.theme = await store.get(LocalData.theme); 
    if (global.theme == null) await DataStorage.SetupTheme();
  }

  static async RestoreData() {
    global.theme = await store.get(LocalData.theme);    
    global.server = await store.get(LocalData.server);
    global.domain = ServerManager.domainName(global.server);
    console.log(server, domain);
    global.api_language = await store.get(LocalData.api_language);
    global.news_language = await store.get(LocalData.news_language);
    global.game_version = await store.get(LocalData.game_version);
    global.friend = await store.get(LocalData.friend);
    global.data_saver = await store.get(LocalData.data_saver);
    global.saved_tab = await store.get(LocalData.saved_tab);
    DataStorage.RestorePlayerInfo();
  }

  static async RestorePlayerInfo() {
    global.ads = await store.get(LocalData.has_ads);
    // Whether show ads or not
    if (ads) AdMobInterstitial.requestAd().then(() => AdMobInterstitial.showAd());
    global.user_info = await store.get(LocalData.user_info);
    global.user_data = await store.get(LocalData.userdata);
  }

  static async RestoreSavedData() {
    global.data.language = await store.get(SavedData.language);
    global.data.achievement = await store.get(SavedData.achievement);
    global.data.consumable = await store.get(SavedData.consumable);
    global.data.encyclopedia = await store.get(SavedData.encyclopedia);
    global.data.collection = await store.get(SavedData.collection);
    global.data.collection_item = await store.get(SavedData.collection_item);
    global.data.ship_type = await store.get(SavedData.ship_type);
    global.data.warship = await store.get(SavedData.warship);
    global.data.commander = await store.get(SavedData.commander_skill);
    global.data.map = await store.get(SavedData.map);
    global.data.personal_rating = await store.get(SavedData.personal_rating);
    console.log(global.data);
  }
}

export { DataStorage };