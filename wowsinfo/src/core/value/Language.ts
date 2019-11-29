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
    agreement_agree: 'Accept',
    agreement_disagree: 'Decline',
    agreement_you_have_to_agree: "If you don't agree, you couldn't use WoWs Info.",
    agreement_retry: 'Try again',
  },
  id: {
    back_button: 'Back',
    welcome_to_wows_info: 'Welcome to WoWs Info',
    welcome_next_button: 'Next (2/4)',
    agreement_you_have_to_agree: "If you don't agree, you couldn't use WoWs Info.",
  },
  ja: {
    back_button: '戻る',
    welcome_to_wows_info: 'WoWs Infoへようこそ',
    welcome_next_button: '次へ　「四の二」',
    agreement_agree: 'いいよ',
    agreement_disagree: 'ダメ',
    agreement_you_have_to_agree: '賛成しない場合は使用できません＞＿＜',
    agreement_retry: 'ゼロからもう一度始めよう',
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
