/**
 * The base of all downloaders
 */
export abstract class BasicDownloader {
  private link: string = 'https://api.worldofwarships.';
  private server?: string;
  private json?: any;

  constructor(server: string) {
    this.server = server;
    // https://api.worldofwarships.asia/
    this.link += server + '/';
  }

  /**
   * Fetch data from link
   */
  async fetchData() {
    let response = await fetch(this.link);
    if (response.status === 200) {
      // Only read it if it has a valid response
      this.json = await response.json();
    }
  }

  /**
   * Parse data into objects
   */
  abstract parseData(): object

  /**
   * Get data name (from constants)
   */
  abstract getName(): string
}
