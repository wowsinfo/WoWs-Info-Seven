import { WoWsAPI } from "../../value/api";

class Downloader {
  constructor(server) {
    // Convert server index to string
    this.server = server;
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
    WoWsAPI.GameVersion;
  }
}

export { Downloader };
