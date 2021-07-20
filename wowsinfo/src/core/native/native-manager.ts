import {QuickActionManager} from './quick-action-manager';

class NativeManager {
  private static _instance: NativeManager;
  private constructor() {}

  public static get Instance() {
    // Do you need arguments? Make it a regular static method instead.
    return this._instance || (this._instance = new this());
  }

  quickActionManager = new QuickActionManager();

  setup() {
    this.quickActionManager.addListener('quick_action', type => {
      console.log(`QuickActionManager - ${type}`);
      switch (type) {
        case 'search':
          // Push to search
          break;
        case 'warships':
          // Push to wiki warhips
          break;
        case 'account':
          // Push to main account
          break;
        default:
          console.log(`Unknown action - ${type}`);
      }
    });
  }
}

export {NativeManager};
