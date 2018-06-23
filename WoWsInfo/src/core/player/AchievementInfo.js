import { API } from '../../constant/value';
import { ServerManager } from '../../core';

class AchievementInfo {
  constructor(id, server) {
    let format = require('string-format');
    this.api = format(API.AchievementInfo, ServerManager.domainName(server)) + id;
    this.id = id;
  }

  async getPlayerAchievement() {
    try {
      let response = await fetch(this.api);
      let json = await response.json();
      if (json != null && json.status == 'ok') {
        let achievement = json.data[this.id].battle;
        var info = [];
        for (key in achievement) {
          let curr = data.achievement[key];
          if (curr == null) continue;
          let copy = Object.assign({}, curr);
          copy.count = achievement[key];
          info.push(copy);
        }
        info.sort(function(a, b) { return b.count - a.count })
        // console.log(global.achievementJson);
        return info;
      }
    } catch (error) {
      console.error(error);
    }
  }
}

export { AchievementInfo };