import { Preference } from "./Preference";
import AsyncStorage from "@react-native-community/async-storage";
import { DATA_KEY } from "../Cacheable";
import { langs } from "src/core/value/Language";

class ApiLanguage implements Preference {
  private userLanguage?: string;
  get UserLanguage(): string {
    return this.userLanguage!;
  }

  constructor();
  constructor(userLanguage: string);
  constructor(userLanguage?: string) {
    this.userLanguage = userLanguage;
  }

  default() {
    this.userLanguage = langs.getLanguage();

    this.save();
  }

  save() {
    AsyncStorage.setItem(DATA_KEY.user_app_language, JSON.stringify(this));
  }

  async load() {
    let jsonString = await AsyncStorage.getItem(DATA_KEY.user_app_language);
    if (!this.fromJSON(jsonString)) {
      this.default();
    }
  }

  fromJSON(jsonString: string | null) {
    if (jsonString) {
      let json = JSON.parse(jsonString);
      this.userLanguage = json.userLanguage;
      return true;
    } else {
      return false;
    }
  }
}

export { ApiLanguage };
