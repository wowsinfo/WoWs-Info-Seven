export interface DataManager {
    /**
     * Setup and load data into memory
     */
    load(): void;
    /**
     * Write object into storage
     */
    save(): void;

    /**
     * Check if an update is necessary
     */
    update(): void;

    /**
     * Get value from key
     * @param key a key from constant
     */
    getValue(key: String): Object;
}
