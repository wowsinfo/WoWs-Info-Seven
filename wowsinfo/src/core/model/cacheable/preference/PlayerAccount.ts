import { Preference } from "./Preference";
import { GameServer } from "./GameServer";
import AsyncStorage from "@react-native-community/async-storage";
import { DATA_KEY } from "../Cacheable";

class PlayerAccount implements Preference {
  private playerID?: string;
  private playerName?: string;
  private playerServer?: GameServer;

  constructor();
  constructor(id: string, name: string, server: GameServer);
  constructor(id?: string, name?: string, server?: GameServer) {
    this.playerID = id;
    this.playerName = name;
    this.playerServer = server;
  }

  default() {
    /// Nothing
  }

  save() {
    AsyncStorage.setItem(DATA_KEY.user_account, JSON.stringify(this));
  }
  
  async load() {
    let jsonString = await AsyncStorage.getItem(DATA_KEY.user_account);
    if (jsonString) {
      let json = JSON.parse(jsonString);
      const { playerID, playerName, playerServer } = json;
      this.playerID = playerID;
      this.playerName = playerName;
      this.playerServer = playerServer;
    }
  }

}