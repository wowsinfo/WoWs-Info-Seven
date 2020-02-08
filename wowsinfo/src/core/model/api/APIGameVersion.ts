import { APIRepsonse } from "./APIRepsonse";

class APIGameVersion extends APIRepsonse {
    game_version? : string;

    constructor(json: any) {
      super(json);
      this.game_version = json.data.game_version;
    }
}

export { APIGameVersion };
