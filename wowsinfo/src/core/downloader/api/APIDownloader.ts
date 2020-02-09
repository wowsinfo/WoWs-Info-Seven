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
  private json?: any = null;

  constructor(server: string) {
    // e.g. https://api.worldofwarships.asia/
    this.link += server + '/';
  }

  /**
   * Append to current link to make the complete url
   * - Do not start with a `-`
   */
  appendLink = (more: string) => this.link + more;

  /**
   * Get the hidden for data request
   */
  getKey = () => this.key;

  /**
   * Get current json
   */
  getJSON = () => this.json;

  /**
   * Check if this request was successful
   * - json must not be null
   */
  isValid = () => this.json != null;

  /**
   * Fetch data from link
   */
  async fetch() {
    // Fetch data from url and catch timeout error
    let response = await this.timeoutFetch(this.link)
    .catch((err: Error) => console.log(err.message));

    if (response) {
      if (response.status === 200) {
        // Only read it if it has a valid response
        const jsonToSave = await response.json();
        // Check if meta.status is ok as well
        if (jsonToSave.meta.status === 'ok') {
          this.json = jsonToSave;
        }
      }
    }
  }

  /**
   * A better fetch with timeout built-in
   * - from https://stackoverflow.com/a/49857905
   * @param url url to be fetched
   * @param time timeout time, 7 second by default
   */
  private timeoutFetch(url: string, time: number = 7000) {
    // Race which one is faster
    return Promise.race<Promise<Response>>([
      fetch(url),
      new Promise((_, reject) => {
        // Timeout after a few seconds to throw an error
        setTimeout(() => reject(new Error(`Timeout, request to ${url} took too long`)), time);
      }),
    ]);
  }

  /**
   * Parse data into models
   * - It is null if request failed or other errors
   */
  abstract parse(): object | null

  /**
   * The game of this data to be saved locally
   */
  abstract name(): string
}
