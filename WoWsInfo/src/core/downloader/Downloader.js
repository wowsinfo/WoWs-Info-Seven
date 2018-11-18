import { WoWsAPI } from "../../value/api";
import { SERVER } from "../../value/data";

class Downloader {
  constructor(server) {
    // Convert server index to string
    this.server = SERVER[server];
  }
  /**
   * Update all data if there is a new version except for force mode
   * @param {Boolean} force 
   */
  static async updateAll(force) {
    // Get server version

  }

  /**
   * Get game server version of WoWs
   */
  static async getVersion() {
    const format = require('string-format');
    let link = format(WoWsAPI.GameVersion, this.server);
    
  }
}

export { Downloader };
