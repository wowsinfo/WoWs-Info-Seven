class Language {
  static getCurrentLanguage() {
    var lang = global.appLanguage;
    if (global.firstLaunch) {
      // Get current language
      var DeviceInfo = require('react-native-device-info');
      lang = DeviceInfo.getDeviceLocale();
      if (lang.includes('-')) {
        // Simplify -> ja-US to ja only
        lang = lang.split('-').slice(0, -1);
        // Basic filter
        switch (lang[0]) {
          case 'cs':
          case 'de':
          case 'en':
          case 'es':
          case 'fr':
          case 'ja':
          case 'pl':
          case 'pt':
          case 'ru':
          case 'th':
          case 'tr':
          case 'zh':
            lang = lang.join('-'); break;
          default:
            // This language is not supported
            lang = 'unknown'; break;
        }
      }
    }

    // Traditional Chinese following wargaming's naming
    if (lang == 'zh-Hant') lang = 'zh-tw';
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
    return lang;
  }

  static setApiLanguage() {
    
  }

  static setAppLanguage() {

  }
}

export {Language};