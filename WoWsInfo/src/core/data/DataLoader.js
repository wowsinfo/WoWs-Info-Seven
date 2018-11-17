/**
 * Load all saved data to global
 */
import { AsyncStorage } from 'react-native';
import { LOCAL, SAVED } from '../../value/data';

class DataLoader {
  /**
   * Load all data from storage
   * Return an object with all data
   */
  static async loadAll() {
    // Get all keys from LOCAL and SAVED and merge theme
    const data = Object.assign(await this.loadObj(LOCAL), await this.loadObj(SAVED));
    return data;
  }

  /**
   * Get all key values and load them to global
   * @param {object} section 
   */
  static async loadObj(section) {
    let data = {};
    // Load all keys from object and get their value from storage
    for (let k in section) {
      const curr = section[k];
      // Get it from storage
      let val = await AsyncStorage.getItem(curr);
      data[curr] = JSON.parse(val);
    }
    return data;
  }
}

export { DataLoader };
