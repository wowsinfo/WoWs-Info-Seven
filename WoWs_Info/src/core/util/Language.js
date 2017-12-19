import { Alert } from 'react-native';

class Language {
  static getCurrentLanguage() {
    var lang = global.appLanguage;
    if (global.firstLaunch) {
      // Get current language
      var DeviceInfo = require('react-native-device-info');
      lang = DeviceInfo.getDeviceLocale().toLocaleLowerCase() + '-';
      // Simplify -> ja-US to ja only
      let simplified = lang.split('-')[0];
      // Basic filter
      switch (simplified) {
        case 'cs':
        case 'de':
        case 'en':
        case 'fr':
        case 'ja':
        case 'pl':
        case 'ru':
        case 'th':
        case 'tr': lang = simplified; break;          
        case 'zh':
          if (!lang.includes('zh-Hant') && !lang.includes('zh-tw')) lang = 'zh';
          else lang = 'zh-tw';
          break;
        case 'es': 
          if (lang.includes('es-mx')) lang = 'es-mx';
          else lang = 'es';
          break;
        case 'pt': lang = 'pt-br'; break;          
        default:
          // This language is not supported
          lang = 'unknown'; break;
      }
      Alert.alert(lang);      
    }
    // console.log(lang);
    return lang;
  }

  // &language=en
  static getApiLangStr() {
    var lang = global.apiLanguage;
    if (lang == 'unknown') lang = 'en';
    if (lang == 'zh-Hans') lang = 'zh-cn';
    return '&language=' + lang;
  }

  static getNewsLangStr() {
    var lang = global.apiLanguage;
    if (lang.includes('zh')) lang = 'zh-tw';
    return lang;
  }
}

export {Language};