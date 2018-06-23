class PlayerConverter {
  static fromString(string) {
    var playerObj = string.split('|');
    return {name: playerObj[0], id: playerObj[1], server: playerObj[2]}
  }

  static toString(obj) {
    if (obj == null || obj.id == '') return null;
    return [obj.name, obj.id, obj.server].join('|');
  }
}

export { PlayerConverter };