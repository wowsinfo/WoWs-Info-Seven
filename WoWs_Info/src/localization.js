import LocalizedStrings from 'react-localization';
import { Language } from './core/';

let strings = new LocalizedStrings({
  en: {
    // Loading
    loading: 'Loading...',
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
    // Tabs
    wiki: 'Wiki',
    news: 'News',
    settings: 'Settings',
    // Back title
    back: 'Back',
    // Wiki
    achievement: 'Achievement',
    flag_camouflage: 'Flag/Camouflage',
    upgrade: 'Upgrade',
    commander: 'Commander',
    warship: 'Warship',
    map: 'Map',
    // Settings
    api_language: 'Change API language',
    app_language: 'Change App language',
    news_language: 'Change News language',
  },
  zh: {
    // Loading
    loading: '加载中...',
    download_data: '下载数据中...',
    // Date
    today: '今天',
    yesterday: '昨天',
    days_ago: '天前',
    // Server
    russia: '俄罗斯',
    europe: '欧洲',
    north_america: '北美',
    asia: '亚洲',
    server: '服务器',
    // Tabs
    wiki: '维基',
    news: '最新消息',
    settings: '设置',
    // Back title
    back: '返回',
    // Wiki
    achievement: '成就',
    flag_camouflage: '旗子/迷彩',
    upgrade: '升级品',
    commander: '舰长技能',
    warship: '战舰',
    map: '地图',
    // Settings
    api_language: '改变服务器语言',
    app_language: '改变APP语言',
    news_language: '改变最新消息语言',
  },
  'zh-tw': {
  },
  ja: {
  },
});

// Set to current language
strings.setLanguage(Language.getCurrentLanguage());

export default strings;