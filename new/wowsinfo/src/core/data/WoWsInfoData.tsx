/**
 * This class handles all data related to wows info 
 * - Setup default value and load local data into memory
 * - Get data from memory (with keys)
 * - Methods for getting and updating values (with keys)
 * - Safe storage
 */
export class WoWsInfoData {
    private static data: WoWsInfoData;

    // Hide constructor
    private constructor() { }

    /**
     * Get data from WoWsInfoData
     */
    public static get instance() {
        if (this.data == null) {
            this.data = new WoWsInfoData();
        }
        return this.data;
    }
}
