import LocalizedStrings from 'react-localization';
import Language from './core/Language';

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

// Set to current language
strings.setLanguage(Language.getCurrentLanguage());

export default strings;