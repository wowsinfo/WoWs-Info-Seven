import { APIRepsonse } from "./APIRepsonse";

class APIPlayerInfo extends APIRepsonse {
  game_version? : string;

  constructor(json: any) {
    super(json);
    this.game_version = json.data.game_version;
  }

  /**
   * Check if the new version we get is different from the local one
   * - Assume that WarGaming won't decrease the version number
   * @param currVersion Current game version saved locally
   */
  isNewVersion(currVersion: string): boolean {
    if (this.game_version) {
      return this.game_version === currVersion;
    }

    return false;
  }
}

export { APIPlayerInfo };
