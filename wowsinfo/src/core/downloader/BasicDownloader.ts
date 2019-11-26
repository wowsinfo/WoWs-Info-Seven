/**
 * The base of all downloaders
 */
export abstract class BasicDownloader {
  private link!: string;
  private json?: any;

  constructor(link: string) {
    this.link = link;
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
