import { Cacheable } from "../../Cacheable";
import AsyncStorage from "@react-native-community/async-storage";

class BasicSaver {
  private dataToSave: Cacheable;

  constructor(data: Cacheable) {
    this.dataToSave = data;
  }

  /**
   * Save `Cacheable` to local storage
   */
  save() {
    AsyncStorage.setItem(this.dataToSave.getName(), this.dataToSave.json());
  }
}

export { BasicSaver };
