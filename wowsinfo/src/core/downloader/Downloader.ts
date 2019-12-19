/**
 * Aall downloaders need to implement this interface
 * - API
 * - Github
 * - Number
 */
export interface Downloader {
  fetch(): void;
  parse(): any;
  name(): string;
};
