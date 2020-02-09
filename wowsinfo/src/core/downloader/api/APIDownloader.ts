import { AppKey } from './key';
import { Downloader } from '../Downloader';

/**
 * The base of all downloaders
 */
export abstract class APIDownloader implements Downloader {
  private link: string = 'https://api.worldofwarships.';
  /**
   * This is your developer key. 
   * Please get one from https://developers.wargaming.net/ and never share it with people you don't trust
   */
  private readonly key: string = AppKey;
  private server?: string;
  private json?: any;

  constructor(server: string) {
    this.server = server;
    // e.g. https://api.worldofwarships.asia/
    this.link += server + '/';
  }

  /**
   * Fetch data from link
   */
  async fetch() {
    let response = await fetch(this.link);
    if (response.status === 200) {
      // Only read it if it has a valid response
      this.json = await response.json();
      // Check if meta.status is ok as well
    }
  }

  abstract parse(): object
  abstract name(): string
}
