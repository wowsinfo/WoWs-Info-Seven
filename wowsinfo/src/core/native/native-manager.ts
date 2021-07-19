import {QuickActionManager} from './quick-action-manager';

class NativeManager {
  private static _instance: NativeManager;

  public static get Instance() {
    // Do you need arguments? Make it a regular static method instead.
    return this._instance || (this._instance = new this());
  }

  private constructor() {}

  setup() {
    QuickActionManager.Instance.setup();
  }
}

export {NativeManager};
