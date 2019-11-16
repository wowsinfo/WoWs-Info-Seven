/**
 * It has all data related functions
 */
export default class DataStorage {
    /// Singleton pattern
    private static _instance: DataStorage;
    private constructor() {}
    public static get Instance() {
        // This is only called once
        if (this._instance == null) this._instance = new DataStorage();
        return this._instance;
    }

    /// 

}