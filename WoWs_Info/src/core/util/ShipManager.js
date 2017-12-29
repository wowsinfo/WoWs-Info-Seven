class ShipManager {
  static getImage(type) {
    let typeJson = global.shipTypeJson;
    switch (typeJson[type]) {
      case typeJson.AirCarrier: return require('../../img/AircraftCarrier.png');
      case typeJson.Battleship: return require('../../img/Battleship.png');
      case typeJson.Cruiser: return require('../../img/Cruiser.png');
      case typeJson.Destroyer: return require('../../img/Destroyer.png');
      default: return null;
    }
  }
}

export {ShipManager};