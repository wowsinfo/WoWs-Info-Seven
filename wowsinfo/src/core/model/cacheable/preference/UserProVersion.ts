import { Preference } from "./Preference";
import AsyncStorage from "@react-native-community/async-storage";
import { DATA_KEY } from "../Cacheable";

class UserProVersion implements Preference {
  private userProVersion?: boolean;
  get UserProVersion(): boolean {
    return this.userProVersion!;
  }

  constructor();
  constructor(userProVersion: boolean);
  constructor(userProVersion?: boolean) {
    this.userProVersion = userProVersion;
  }

  default() {
    this.userProVersion = false;

    this.save();
  }

  save() {
    AsyncStorage.setItem(DATA_KEY.user_pro_version, JSON.stringify(this));
  }

  async load() {
    let jsonString = await AsyncStorage.getItem(DATA_KEY.user_pro_version);
    this.fromJSON(jsonString);
  }

  fromJSON(jsonString: string | null) {
    if (jsonString) {
      let userProVersion = JSON.parse(jsonString);
      if (userProVersion) {
        this.userProVersion = userProVersion;
      }
    } else {
      this.default();
    }
  }
}

export { UserProVersion };
