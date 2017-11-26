// Get current game version from api
class GameVersion {
  static hasUpdate() {
    return true;
  }

  static updateVersion() {
    return '0.6.13.0';
  }
}

export {GameVersion};