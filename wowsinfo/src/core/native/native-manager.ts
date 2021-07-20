import {QuickActionManager} from './quick-action-manager';

class NativeManager {
  private static _instance: NativeManager;
  private constructor() {}

  public static get Instance() {
    // Do you need arguments? Make it a regular static method instead.
    return this._instance || (this._instance = new this());
  }

  quickActionManager!: QuickActionManager;

  setup() {
    this.quickActionManager = new QuickActionManager();
  }
}

export {NativeManager};
