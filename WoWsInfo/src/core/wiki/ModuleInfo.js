import { API } from "../../constant/value";
import { Language } from "..";

class ModuleInfo {
  static async getUpdatedInfo(ship_id, modules) {
    try {
      var format = require('string-format');
      var api = format(API.ShipModule, domain, ship_id);
      for (module in modules) {
        let curr = modules[module];
        api += '&' + curr.key + '_id=' + curr.id;
      }
      api += Language.getApiLangStr();
      console.log(api);
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

export { ModuleInfo };