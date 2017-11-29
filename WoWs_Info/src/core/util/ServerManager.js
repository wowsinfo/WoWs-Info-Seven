import { localDataName } from '../../constant/value';
import { StorageManager } from './';
import strings from '../../localization';

class ServerManager {
  static getCurrName(index) {
    let parsed = parseInt(index);
    switch (parsed) {
      case 0: return strings.russia;
      case 1: return strings.europe;
      case 2: return strings.north_america;
      case 3: return strings.asia;
      default: return '';
    }
  }

  static getDomainFrom(index) {
    if (index > 3) return 'com';
    let domain = ['ru', 'eu', 'com', 'asia'];
    return domain[index];
  }

  static getNumberDomainFrom(index) {
    return 'asia';
  }
}

export {ServerManager};