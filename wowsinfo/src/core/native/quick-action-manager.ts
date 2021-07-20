import {NativeModules, NativeEventEmitter} from 'react-native';
const QuickActionManagerSwift = NativeModules.QuickActionManager;

class QuickActionManager {
  constructor() {
    const eventEmitter = new NativeEventEmitter(QuickActionManagerSwift);
    eventEmitter.addListener('quick_action', type => {
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
