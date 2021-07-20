import {NativeModules, NativeEventEmitter} from 'react-native';
const NativeQuickActionManager = NativeModules.QuickActionManager;

class QuickActionManager extends NativeEventEmitter {
  constructor() {
    super(NativeQuickActionManager);
  }

  addMainAccount(name: string) {
    NativeQuickActionManager.addMainAccount(name);
  }
}

export {QuickActionManager};
