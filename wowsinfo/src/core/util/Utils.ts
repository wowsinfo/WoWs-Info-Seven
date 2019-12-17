import { Platform } from "react-native";

export default class Utils {
  /**
   * Get current version string
   * - IOS version and Android version are different
   */
  public static getCurrentVersion(): string {
    if (this.isIOS()) return '1.7.0';
    return '1.1.0';
  }

  public static isIOS(): boolean {
    return Platform.OS === 'ios';
  }
}
