import { WoWsAPI } from "../../value/api";
import { SERVER } from "../../value/data";
import { SafeFetch } from '../';

class Downloader {
  constructor(server) {
    // Convert server index to string
    this.server = SERVER[server];
    console.log(`Downloader\nYou server is '${this.server}'`);
  }
  /**
   * Update all data if there is a new version except for force mode
   * @param {Boolean} force 
   */
  async updateAll(force=false) {
    // Get server version
    console.log('Checking for new version');
    await this.getVersion();
  }

  /**
   * Get game server version of WoWs
   */
  static async getVersion() {
    SafeFetch.get(WoWsAPI.GameVersion, this.server);
  }
}

export { Downloader };
