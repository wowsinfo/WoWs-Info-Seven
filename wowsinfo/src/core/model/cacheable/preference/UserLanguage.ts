import { Preference } from "./Preference";
import AsyncStorage from "@react-native-community/async-storage";
import { DATA_KEY } from "../Cacheable";
import { langs } from "src/core/value/Language";

class UserLanguage implements Preference {
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
    this.fromJSON(jsonString);
  }

  fromJSON(jsonString: string | null) {
    if (jsonString) {
      let json = JSON.parse(jsonString);
      if (json.userLanguage) {
        this.userLanguage = json.userLanguage;
      } else {
        this.default();
      };
    }
  }
}

export { UserLanguage };
