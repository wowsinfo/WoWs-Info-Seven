import { Cacheable } from "../model/cacheable/Cacheable";

/**
 * Everything which are saved locally
 * - Wiki
 * - Main account
 * - Language
 * - Theme
 * - Pro version
 * - First launch
 * - Game server
 * - More...
 * 
 * It also some constants to be shared
 */
class LocalData {
  static Version: string = '1.1.0';
  static IOSVersion: string = '1.7.0';
  static GameVersion: string = '0.8.10.0';
  static GitHubLink: string = 'https://github.com/HenryQuan/WoWs-Info';
  static AppStoreLink: string = 'https://itunes.apple.com/app/id1202750166';
  static GooglePlayLink: string = 'https://play.google.com/store/apps/details?id=com.yihengquan.wowsinfo';
  static DeveloperEMail: string = `mailto:development.henryquan@gmail.com?subject=[WoWs Info ${LocalData.Version}] `;
  static PersonalRatingLink: string = 'https://wows-numbers.com/personal/rating';
  static LatestReleaseLink: string = `${LocalData.GitHubLink}/releases/latest`;

  constructor() { }

  /**
   * All essential data
   * - Theme
   * - Language
   * - First launch
   * - Pro version
   */
  essential(): Cacheable[] {
    return [];
  }

  /**
   * Everything that are not essential
   */
  rest(): Cacheable[] {
    return [];
  }
}

export { LocalData };
