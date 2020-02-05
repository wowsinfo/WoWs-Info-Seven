import { Preference } from "./Preference";
import AsyncStorage from "@react-native-community/async-storage";
import { DATA_KEY } from "../Cacheable";
import { LocalData } from "src/core/data/LocalData";

class AppVersion implements Preference {
  private appVersion?: string;
  get AppVersion(): string {
    return this.appVersion!;
  }

  constructor();
  constructor(appVersion: string);
  constructor(appVersion?: string) {
    this.appVersion = appVersion;
  }

  default() {
    this.appVersion = LocalData.Version;

    this.save();
  }

  save() {
    AsyncStorage.setItem(DATA_KEY.user_app_version, JSON.stringify(this));
  }

  async load() {
    let jsonString = await AsyncStorage.getItem(DATA_KEY.user_app_version);
    this.fromJSON(jsonString);
  }

  fromJSON(jsonString: string | null) {
    if (jsonString) {
      let currVersion = JSON.parse(jsonString);
      if (currVersion) {
        this.appVersion = currVersion;
      };
    } else {
      this.default();
    };
  }
}

export { AppVersion };
