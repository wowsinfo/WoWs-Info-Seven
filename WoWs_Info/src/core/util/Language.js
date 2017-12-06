class Language {
  static getCurrentLanguage() {
    // Get current language
    var DeviceInfo = require('react-native-device-info');
    var lang = DeviceInfo.getDeviceLocale();
    // Traditional Chinese
    if (lang.includes('zh-Hant')) lang = 'zh-Hant';
    // console.log(lang);
    return lang;
  }

  // &language=en
  static getLangStr() {
    return '&language=' + global.apiLanguage;
  }

  // These two funtions are based on getCurrentLanguage
  static getApiLanguage() {
    // Based on user selection
    return Language.getCurrentLanguage();
  }

  static getNewsLanguage() {
    let lang =  Language.getCurrentLanguage();
    return lang;
  }

  static setApiLanguage() {

  }

  static setAppLanguage() {

  }
}

export {Language};