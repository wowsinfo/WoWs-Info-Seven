import { Cacheable } from "../Cacheable";

interface Preference extends Cacheable {
    /**
   * This is the default value if load cannot get anything
   */
  default(): void;
}