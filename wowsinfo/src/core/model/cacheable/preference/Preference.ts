import { Cacheable } from "../Cacheable";

export interface Preference extends Cacheable {
    /**
   * This is the default value if load cannot get anything
   * - After setting to default
   * - The model will save it
   * @pre save() works
   * @post default value will be saved()
   */
  default(): void;
}