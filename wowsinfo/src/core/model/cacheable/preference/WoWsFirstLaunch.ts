import { Preference } from "./Preference";
import AsyncStorage from "@react-native-community/async-storage";
import { DATA_KEY } from "../Cacheable";

class WoWsFirstLaunch implements Preference {
  private firstLaunch?: boolean;
  get FirstLaunch(): boolean {
    return this.firstLaunch!;
  }

  constructor();
  constructor(firstLaunch: boolean);
  constructor(firstLaunch?: boolean) {
    this.firstLaunch = firstLaunch;
  }

  default() {
    this.firstLaunch = true;

    this.save();
  }

  save() {
    AsyncStorage.setItem(DATA_KEY.user_first_launch, JSON.stringify(this));
  }

  async load() {
    let jsonString = await AsyncStorage.getItem(DATA_KEY.user_first_launch);
    this.fromJSON(jsonString);
  }

  fromJSON(jsonString: string | null) {
    if (jsonString) {
      let firstLaunch = JSON.parse(jsonString);
      if (firstLaunch) {
        this.firstLaunch = firstLaunch;
      }
    } else {
      this.default();
    }
  }
}

export { WoWsFirstLaunch };
