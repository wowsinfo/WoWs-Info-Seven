import LocalizedStrings from 'react-native-localization';

/**
 * All languages available so far
 */
export const languageAvailable = {
  en: 'en',
  id: 'id',
  ja: 'ja',
  zh: 'zh',
  zh_hant: 'zh-hant',
};

/**
 * Localisation
 */
const langs = new LocalizedStrings({
  en: {
    back_button: 'Back',
    welcome_to_wows_info: 'Welcome to WoWs Info',
    welcome_next_button: 'Next (2/4)',
  },
  id: {
    back_button: 'Back',
    welcome_to_wows_info: 'Welcome to WoWs Info',
    welcome_next_button: 'Next (2/4)',
  },
  ja: {
    back_button: '戻る',
    welcome_to_wows_info: 'WoWs Infoへようこそ',
    welcome_next_button: '次へ　「四の二」',
  },
  zh: {
    back_button: 'Back',
    welcome_to_wows_info: 'Welcome to WoWs Info',
    welcome_next_button: 'Next (2/4)',
  },
  'zh-hant': {
    back_button: 'Back',
    welcome_to_wows_info: 'Welcome to WoWs Info',
    welcome_next_button: 'Next (2/4)',
  },
});

langs.setLanguage(languageAvailable.en);

export { langs };
