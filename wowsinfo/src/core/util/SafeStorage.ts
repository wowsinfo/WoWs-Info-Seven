/**
 * Get and set storage keys safely
 */
import AsyncStorage from '@react-native-async-storage/async-storage';

class SafeStorage {
  /**
   * Get a key from async storage and return a default value if not defined
   * It will also save the default value if it is null
   * @param {string} key
   * @param {any} value
   */
  static async get(key: string, value: any): Promise<any> {
    const data = await AsyncStorage.getItem(key);
    if (data) {
      // Return parsed value
      return JSON.parse(data);
    } else {
      // Save the default value
      this.set(key, value);
      return value;
    }
  }

  /**
   * Set any values to a key
   * @param {string} key
   * @param {any} value
   */
  static async set(key: string, value: any): Promise<void> {
    // Stringify values to json format
    await AsyncStorage.setItem(key, JSON.stringify(value));
  }

  /**
   * Clear everything (debug only)
   */
  static clear() {
    if (__DEV__) {
      console.log('Clearing storage');
      AsyncStorage.clear();
    }
  }
}

export {SafeStorage};
