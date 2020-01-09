import { Preference } from "./Preference";
import AsyncStorage from "@react-native-community/async-storage";
import { DATA_KEY } from "../Cacheable";

class ApiLanguage implements Preference {
  private apiLanguage?: string;
  get ApiLanguage(): string {
    return this.apiLanguage!;
  }

  constructor();
  constructor(apiLanguage: string);
  constructor(apiLanguage?: string) {
    this.apiLanguage = apiLanguage;
  }

  default() {
    this.apiLanguage = 'en';

    this.save();
  }

  save() {
    AsyncStorage.setItem(DATA_KEY.user_server_language, JSON.stringify(this));
  }

  async load() {
    let jsonString = await AsyncStorage.getItem(DATA_KEY.user_server_language);
    this.fromJSON(jsonString);
  }

  fromJSON(jsonString: string | null) {
    if (jsonString) {
      let json = JSON.parse(jsonString);
      if (json.apiLanguage) {
        this.apiLanguage = json.apiLanguage;
      } else {
        this.default();
      };
    }
  }
}

export { ApiLanguage };
