import { Preference } from "./Preference";
import AsyncStorage from "@react-native-community/async-storage";
import { DATA_KEY } from "../Cacheable";

class WoWsRSIP implements Preference {
  private rsip?: string;
  get Rsip(): string {
    return this.rsip!;
  }

  constructor();
  constructor(rsip: string);
  constructor(rsip?: string) {
    this.rsip = rsip;
  }

  default() {
    // do nothing
  }

  save() {
    AsyncStorage.setItem(DATA_KEY.wows_rs_ip, JSON.stringify(this));
  }

  async load() {
    let jsonString = await AsyncStorage.getItem(DATA_KEY.wows_rs_ip);
    this.fromJSON(jsonString);
  }

  fromJSON(jsonString: string | null) {
    if (jsonString) {
      let rsip = JSON.parse(jsonString);
      if (rsip) {
        this.rsip = rsip;
      }
    }
  }
}

export { WoWsRSIP };
