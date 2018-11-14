/**
 * Load all saved data to global
 */
import { AsyncStorage } from 'react-native';

class DataLoader {
  static async loadAll() {
    const keys = await AsyncStorage.getAllKeys();
    let DATA = {};
    for (let k of keys) {
      let val = await AsyncStorage.getItem(k);
      DATA[k] = JSON.parse(val)
    }
    return DATA;
  }
}

export { DataLoader };
