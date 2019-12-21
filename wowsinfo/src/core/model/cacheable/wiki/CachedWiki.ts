import { Cacheable } from "../Cacheable";

export interface CachedWiki extends Cacheable {
  /**
   * whether this is a new wiki entry
   */
  newData: boolean;

  /**
   * Check if this is different from the new entry
   * - update `newData` if it is different or new
   */
  diff(wiki: CachedWiki): void;
}