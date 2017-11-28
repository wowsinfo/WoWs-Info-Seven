import LocalizedStrings from 'react-localization';
import { Language } from './core/util';

let strings = new LocalizedStrings({
  en: {
    download_data: 'Downloading data...',
    // Date
    today: 'Today',
    yesterday: 'Yesterday',
    days_ago: ' days ago',
    // Server
    russia: 'Russia',
    europe: 'Europe',
    north_america: 'North America',
    asia: 'Asia',
    server: 'server',
  },
  zh: {
    download_data: '下载数据中...',
    // Date
    today: '今天',
    yesterday: '昨天',
    days_ago: '天前',
    // Server
    russia: '俄国',
    europe: '欧洲',
    north_america: '北美',
    asia: '亚洲',
    server: '服务器',
  },
  'zh-Hant': {
  },
  ja: {
  },
});

// Set to current language
strings.setLanguage(Language.getCurrentLanguage());

export default strings;