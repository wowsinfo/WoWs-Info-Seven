import { Cacheable, DATA_KEY } from "../../model/cacheable/Cacheable";

/**
 * Load a `Cacheable` from a key
 */
export interface BasicLoader {
  key: DATA_KEY;

  /**
   * Load `Cacheable` from `DATA_KEY`
   */
  load(): Cacheable
}
