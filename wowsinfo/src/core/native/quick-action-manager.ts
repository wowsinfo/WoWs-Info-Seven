import {NativeModules, NativeAppEventEmitter} from 'react-native';
const QuickActionManagerSwift = NativeModules.QuickActionManager;

class QuickActionManager {
  private static _instance: QuickActionManager;

  public static get Instance() {
    // Do you need arguments? Make it a regular static method instead.
    return this._instance || (this._instance = new this());
  }

  private constructor() {}

  setup() {
    NativeAppEventEmitter.addListener('quick_action', type => {
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

  addMainAccount(name: string) {
    QuickActionManagerSwift.addMainAccount(name);
  }
}

export {QuickActionManager};
