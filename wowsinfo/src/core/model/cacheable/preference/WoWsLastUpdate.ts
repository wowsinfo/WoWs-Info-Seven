import { Preference } from "./Preference";
import AsyncStorage from "@react-native-community/async-storage";
import { DATA_KEY } from "../Cacheable";

class WoWsLastUpdate implements Preference {
  private lastUpdate?: string;
  get LastUpdate(): string {
    return this.lastUpdate!;
  }

  constructor();
  constructor(lastUpdate: string);
  constructor(lastUpdate?: string) {
    this.lastUpdate = lastUpdate;
  }

  default() {
    this.lastUpdate = new Date().toDateString();

    this.save();
  }

  save() {
    AsyncStorage.setItem(DATA_KEY.user_last_update, JSON.stringify(this));
  }

  async load() {
    let jsonString = await AsyncStorage.getItem(DATA_KEY.user_last_update);
    this.fromJSON(jsonString);
  }

  fromJSON(jsonString: string | null) {
    if (jsonString) {
      let lastUpdate = JSON.parse(jsonString);
      if (lastUpdate) {
        this.lastUpdate = lastUpdate;
      }
    } else {
      this.default();
    }
  }
}

export { WoWsLastUpdate };
