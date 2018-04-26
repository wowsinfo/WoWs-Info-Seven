import { localDataName } from '../../constant/value';
import { StorageManager } from '../';
import language from '../../constant/language';

class ServerManager {
  static domainName(index) {
    let parsed = parseInt(index);
    switch (parsed) {
      case 0: return language.server_russia;
      case 1: return language.server_europe;
      case 2: return language.server_north_america;
      case 3: return language.server_asia;
    }
  }

  static getDomain(index) {
    let domain = ['ru', 'eu', 'com', 'asia'];
    return domain[index];
  }
}

export { ServerManager };