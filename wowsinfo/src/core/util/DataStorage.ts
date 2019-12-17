/**
 * It has all data related functions
 */
export default class DataStorage {
  
  /// Some constants
  public static readonly OK = 'OK';
  
  /// Singleton pattern
  private static _instance: DataStorage;
  private constructor() {}
  public static get Instance() {
    // This is only called once
    if (this._instance == null) this._instance = new DataStorage();
    return this._instance;
  }

  /**
   * Initialise some basic but crutial preferences
   * - Load app theme
   * - Load app language
   * - Check if first launch
   * @returns if true, everything works and it's not first launch
   */
  async initSome(): Promise<boolean> {
    return true;
  }

  /**
   * Initialise the entire app
   * - Check for app update once a week
   * - Check for game update
   * - Update data every 2 weeks even if there are no updates
   * - Download and save data locally
   * - Load data locally
   * @returns error message or 'nothing'
   */
  async initAll(): Promise<string> {
    return DataStorage.OK;
  }
}
