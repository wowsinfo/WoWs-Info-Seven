import { Cacheable, DATA_KEY } from "../../Cacheable";

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
