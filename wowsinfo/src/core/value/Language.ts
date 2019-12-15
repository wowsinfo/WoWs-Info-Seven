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
    welcome_next_button: 'Next',
    agreement_agree: 'Accept',
    agreement_disagree: 'Decline',
    agreement_you_have_to_agree: "If you don't agree, you couldn't use WoWs Info.",
    agreement_retry: 'Try again from ZERO',
    // Remeber to add term of use and privacy policy here
    setup_language_title: 'App language',
    setup_server_title: 'Game server',
    setup_wiki_language_title: 'Wiki language',
    setup_wiki_language_caption: 'It includes all ship names and many more...',
    setup_next_button: 'Next',
    // WoWs Info Pro Version
    proversion_title: 'Get WoWs Info Pro :)',
    // Home Tabs
    home_tab_wiki: 'Wiki',
    home_tab_website: 'Website',
    home_tab_search: 'Search',
    home_tab_rs: 'Realtime',
    home_tab_main: 'My Account',
  },
  id: {
    back_button: 'Back',
    welcome_to_wows_info: 'Welcome to WoWs Info',
    welcome_next_button: 'Next - 2/4',
    agreement_you_have_to_agree: "If you don't agree, you couldn't use WoWs Info.",
  },
  ja: {
    back_button: '戻る',
    welcome_to_wows_info: 'WoWs Infoへようこそ',
    welcome_next_button: '次へ',
    agreement_agree: 'いいよ',
    agreement_disagree: 'ダメ',
    agreement_you_have_to_agree: '賛成しない場合は使用できません＞＿＜',
    agreement_retry: 'ゼロからもう一度始めよう',
  },
  zh: {
    back_button: 'Back',
    welcome_to_wows_info: 'Welcome to WoWs Info',
    welcome_next_button: 'Next',
  },
  'zh-hant': {
    back_button: 'Back',
    welcome_to_wows_info: 'Welcome to WoWs Info',
    welcome_next_button: 'Next',
  },
});

langs.setLanguage(languageAvailable.en);

export { langs };
