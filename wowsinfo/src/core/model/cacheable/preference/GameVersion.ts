import { Preference } from "./Preference";
import AsyncStorage from "@react-native-community/async-storage";
import { DATA_KEY } from "../Cacheable";
import { LocalData } from "src/core/data/LocalData";

class GameVersion implements Preference {
  private gameVersion?: string;
  get GameVersion(): string {
    return this.gameVersion!;
  }

  constructor();
  constructor(gameVersion: string);
  constructor(gameVersion?: string) {
    this.gameVersion = gameVersion;
  }

  default() {
    this.gameVersion = LocalData.GameVersion;

    this.save();
  }

  save() {
    AsyncStorage.setItem(DATA_KEY.game_version, JSON.stringify(this));
  }

  async load() {
    let jsonString = await AsyncStorage.getItem(DATA_KEY.game_version);
    this.fromJSON(jsonString);
  }

  fromJSON(jsonString: string | null) {
    if (jsonString) {
      let gameVersion = JSON.parse(jsonString);
      if (gameVersion) {
        this.gameVersion = gameVersion;
      }
    } else {
      this.default();
    }
  }
}

export { GameVersion };
