import DeviceInfo from 'react-native-device-info';

class Language {
  /**
   * Return current user system language
   */
  static getCurrentLanguage() {
    var lang = api_language;
    if (global.first_launch == true) {
      // Get current language
      lang = DeviceInfo.getDeviceLocale().toLocaleLowerCase() + '-';
      console.log("Language: " + lang);   
      
      // Simplify -> ja-US to ja only
      let simplified = lang.split('-')[0];
      // Basic filter
      switch (simplified) {
        case 'cs':
        case 'de':
        case 'en':
        case 'fr':
        case 'ja':
        case 'pl':
        case 'ru':
        case 'th':
        case 'tr': lang = simplified; break;          
        case 'zh':
          if (!lang.includes('zh-Hant') && !lang.includes('zh-tw')) lang = 'zh-cn';
          else lang = 'zh-tw';
          break;
        case 'es': 
          if (lang.includes('es-mx')) lang = 'es-mx';
          else lang = 'es';
          break;
        case 'pt': lang = 'pt-br'; break;          
        default:
          // This language is not supported
          lang = 'en'; break;
      }  
    }  
    // console.log(lang);
    return lang;
  }

  /**
   * Get API Language
   */
  static getApiLangStr() {
    var lang = api_language;
    if (lang == 'zh-Hans') lang = 'zh-cn';
    return '&language=' + lang;
  }
}

export { Language };