class WoWsNumbers {
  static getNumberDomainFrom(index) {
    let domain = ['ru.', '', 'na.', 'asia.'];
    return domain[index];
  }

  static getWebsiteUrl(player, id) {
    var format = require('string-format');
    return format('https://{0}wows-numbers.com/player/{1},{2}/', WoWsNumbers.getNumberDomainFrom(global.server), id, player);
  }
}

export {WoWsNumbers};