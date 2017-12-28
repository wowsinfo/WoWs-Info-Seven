import { API } from '../../constant/value';
import { ServerManager } from '../../core';

class ShipInfo {
  constructor(id, server) {
    let format = require('string-format');
    this.api = format(API.ShipInfo, ServerManager.getDomainFrom(server)) + id;
  }
}

export {ShipInfo};