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
}

export default Language;