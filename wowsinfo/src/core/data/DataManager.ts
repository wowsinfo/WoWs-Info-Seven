import { LocalData } from "./LocalData";

/**
 * It has all data related functions
 */
export default class DataManager {
  
  /// Some constants
  public static readonly OK = 'OK';

  /// Data related
  private data = new LocalData();
  
  /// Singleton pattern
  private static _instance: DataManager;
  private constructor() {}
  public static get Instance() {
    // This is only called once
    if (this._instance == null) this._instance = new DataManager();
    return this._instance;
  }

  /**
   * Initialise some basic but crutial preferences
   * - Load app theme
   * - Load app language
   * - Check if first launch
   * @returns if true, everything works
   */
  async initEssential(): Promise<boolean> {
    const essential = this.data.essential().map(async c => {
      await c.load();
    })
    
    Promise.all(essential)
    .then(() => true)
    .catch(() => false);
  }

  /**
   * Initialise the entire app
   * - Check for app update once a week
   * - Check for game update
   * - Update data every 2 weeks even if there are no updates
   * - Download and save data locally
   * - Load data locally
   * @returns if true, everything works
   */
  async initRest(): Promise<boolean> {
    this.data.rest().forEach(c => c.load());
    return true;
  }
}
