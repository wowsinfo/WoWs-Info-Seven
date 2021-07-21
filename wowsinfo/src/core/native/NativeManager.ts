import {QuickAction} from './QuickAction';
import {NativeModules} from 'react-native';

const ReactNativeManager = NativeModules.ReactNativeManager;

class NativeManager {
  private static _instance: NativeManager;
  private constructor() {}

  public static get Instance() {
    // Do you need arguments? Make it a regular static method instead.
    return this._instance || (this._instance = new this());
  }

  // Keep the listener alive
  private quickActionManager!: QuickAction;

  setup() {
    this.quickActionManager = new QuickAction();
  }

  static appHasLoaded() {
    ReactNativeManager.reactNativeHasLoaded();
  }
}

export {NativeManager};
