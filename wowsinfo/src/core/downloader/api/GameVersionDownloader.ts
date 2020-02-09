import { APIDownloader } from './APIDownloader';
import { APIGameVersion } from 'src/core/model/api/APIGameVersion';

/**
 * Get current game version to check if WoWs Info needs to update data
 */
class GameVersionDownloader extends APIDownloader {
  constructor(server: string) {
    super(server);
    this.appendLink(`wows/encyclopedia/info/?application_id=${this.getKey()}&fields=game_version`);
  }

  parse(): APIGameVersion | null {
    if (this.isValid()) return new APIGameVersion(this.getJSON());
    return null;
  }
  
  name(): string {
    // You don't need to save this
    throw new Error('This method shouldn\'t be called');
  }
}

export { APIDownloader };
