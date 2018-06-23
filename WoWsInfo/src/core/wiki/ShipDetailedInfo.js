import { API } from "../../constant/value";
import { Language } from "..";

class ShipDetailedInfo {
  static async getDefault(ship_id) {
    var format = require('string-format');
    let api = format(API.Ship_Wiki, domain, ship_id) + Language.getApiLangStr();
    try {
      let response = await fetch(api);
      let json = await response.json();
      if (json != null && json.status == 'ok') {
        return json.data[ship_id];
      }
    } catch (error) {
      console.error(error);
    }
  }
}

export { ShipDetailedInfo };