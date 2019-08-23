import { WoWsData } from "./WoWsData";
import { LocalData } from "./LocalData";

/**
 * This class handles all data related to wows info 
 * - Setup default value and load local data into memory
 * - Get data from memory (with keys)
 * - Methods for getting and updating values (with keys)
 * - Safe storage
 */
export class WoWsInfoData {

    private static infoData: WoWsInfoData;
    private wowsData: WoWsData;
    private localData: LocalData;

    // Hide constructor
    private constructor() {
        this.wowsData = new WoWsData();
        this.localData = new LocalData();
     }

    /**
     * Get data from WoWsInfoData
     */
    public static get shared() {
        if (this.infoData == null) {
            this.infoData = new WoWsInfoData();
        }
        return this.infoData;
    }

    /**
     * Load and setup local data, check for update and download data from WarGaming server
     */
    public init(): boolean {
        try {
            this.localData.load();
            return true;
        } catch (error) {
            console.error(error);
            return false;
        }
    }

    /**
     * Make sure you poss a value from LocaDataKeys
     * @param key 
     */
    public getLocalValue(key: String): Object {
        return this.localData.getValue(key);
    }

    public getWoWsValue(key: String): Object {
        return {};
    }

}
