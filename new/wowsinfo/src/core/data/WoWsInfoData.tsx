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

    private infoData: WoWsInfoData | undefined;
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
    public get instance() {
        if (this.infoData == null) {
            this.infoData = new WoWsInfoData();
        }
        return this.infoData;
    }

    /**
     * Load or setup local data, check for update and download data from WarGaming server
     */
    public init(): boolean {
        try {
            return true;
        } catch (error) {
            console.error(error);
            return false;
        }
    }

}
