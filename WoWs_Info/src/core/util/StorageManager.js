import { AsyncStorage } from 'react-native';

// Simple AsyncStorage wrapper with try catch
class StorageManager {
  static async getItem(key) {
    try {
      return JSON.parse(await AsyncStorage.getItem(key));
    } catch (error) {
      // Fail to get data
      console.error(error);
    }
  }

  static async setItem(key, object) {
    if (object == null) return;
    try {
      // Stringify object
      await AsyncStorage.setItem(key, JSON.stringify(object));
      console.log(key, object);
    } catch (error) {
      // Fail to set data
      console.error(error);
    }
  }
}

export {StorageManager};