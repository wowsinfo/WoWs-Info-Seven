class Language {
  static getCurrentLanguage() {
    var lang = global.appLanguage;
    if (global.firstLaunch) {
      // Get current language
      lang = 'en';
    }
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
    if (lang.includes('zh')) lang = 'zh-tw';
    return lang;
  }
}

export {Language};