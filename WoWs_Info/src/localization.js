import LocalizedStrings from 'react-localization';

let strings = new LocalizedStrings({
  en: {
    download_data: 'Downloading data...',
  },
  zh: {
    download_data: '下载数据中...',
  },
  'zh-Hant': {
    download_data: '下載數據中...',
  },
  ja: {
    download_data: 'Downloading data...',
  },
});

// Get current language
var DeviceInfo = require('react-native-device-info');
var lang = DeviceInfo.getDeviceLocale();
// Traditional Chinese
if (lang.includes('zh-Hant')) lang = 'zh-Hant';
// console.log(lang);
// Set to current language
strings.setLanguage(lang);

export default strings;