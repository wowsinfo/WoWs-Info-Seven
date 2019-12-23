import { Preference } from "./Preference";
import AsyncStorage from "@react-native-community/async-storage";
import { DATA_KEY } from "../Cacheable";

/// All 4 domains
export enum Server {
  RU = 'ru',
  EU = 'eu',
  US = 'com',
  ASIA = 'asia',
};

class GameServer implements Preference {
  private server?: string;
  get Server(): string {
    return this.server!;
  }

  constructor();
  constructor(server: string);
  constructor(server?: string) {
    this.server = server;
  }

  default() {
    this.server = Server.ASIA;

    this.save();
  }

  save() {
    AsyncStorage.setItem(DATA_KEY.user_server, JSON.stringify(this));
  }

  async load() {
    let jsonString = await AsyncStorage.getItem(DATA_KEY.user_server);
    if (jsonString) {
      let json = JSON.parse(jsonString);
      this.server = json.server;
    } else {
      this.default();
    }
  }
}

export { GameServer };
