import {SAVED} from '../../value/data';

class WarshipUtils {
  static getTierLabel(tier: number): string {
    if (tier < 1) return 'O';
    // From 1 to 15
    const label = WarshipUtils.getTierList();
    return label[tier - 1];
  }

  /**
   * A function that returns a colour between red and green depending on curr / max
   */
  static getColourWithRange(min: number, curr: number, max: number) {
    if (curr < min) return '#FF0000';
    const colourNumber = ((curr - min) / (max - min)) * 100;
    let scale = Number(colourNumber.toFixed(0));

    function componentToHex(c: {toString: (arg0: number) => any}) {
      let hex = c.toString(16);
      hex = hex.substring(0, 2);
      return hex.length == 1 ? '0' + hex : hex;
    }

    function rgbToHex(r: number, g: number, b: number) {
      return '#' + componentToHex(r) + componentToHex(g) + componentToHex(b);
    }

    let G = (255 * scale) / 100;
    let R = (255 * (100 - scale)) / 100;
    let colour = rgbToHex(R, G, 0);
    console.log(colour);
    return colour;
  }

  static getKeyByValue(object: {[x: string]: any}, value: any) {
    return Object.keys(object).find(key => object[key] === value);
  }

  static getTierList() {
    return [
      'I',
      'II',
      'III',
      'IV',
      'V',
      'VI',
      'VII',
      'VIII',
      'IX',
      'X',
      '★', // super ships
      'XII',
      'XIII',
      'XIV',
      'XV',
    ];
  }

  static filterShip(
    data: {premium: any; name: any; nation: any; type: any; tier: any},
    shipData = null,
  ) {
    const {premium, name, nation, type, tier} = data;
    console.log(data);
    if (
      premium === false &&
      name == '' &&
      nation.length === 0 &&
      type.length === 0 &&
      tier.length === 0
    ) {
      return null;
    }

    // nation, type and tier need to be normalised
    let fname = name.toLowerCase();
    let fdata = WarshipUtils.normalise(nation, type, tier);

    console.log(fdata);
    let warship = DATA[SAVED.warship];
    let filtered = [];
    if (shipData != null) {
      for (let ship of shipData) {
        let curr = warship[ship.ship_id];
        // Ignore removed ships
        if (curr == null) continue;
        if (WarshipUtils.validShip(curr, fname, fdata, premium)) {
          filtered.push(ship);
        }
      }
    } else {
      for (let ID in warship) {
        let curr = warship[ID];
        if (WarshipUtils.validShip(curr, fname, fdata, premium)) {
          filtered.push(curr);
        }
      }
    }

    let sorted = filtered;
    // shipData is sorted
    if (shipData == null) {
      sorted = filtered.sort((a, b) => {
        // Sort by tier, then by type
        if (a.tier === b.tier) return a.type.localeCompare(b.type);
        else return b.tier - a.tier;
      });
    }

    return sorted;
  }

  static validShip(
    curr: {
      name: string;
      premium: any;
      tier: string | number;
      nation: string | number;
      type: string | number;
    },
    fname: string,
    fdata: {tier: any; nation: any; type: any},
    premium: boolean,
  ) {
    let filterTier = false;
    let filterName = false;
    let filterNation = false;
    let filterType = false;
    let filterPremium = false;

    let ftier = fdata.tier;
    let fnation = fdata.nation;
    let ftype = fdata.type;

    // It includes this name or name is empty
    if (curr.name.toLowerCase().includes(fname) || fname.trim() === '') {
      filterName = true;
    }

    // ANote that if premium is not selected, all ships are valid
    if (curr.premium === premium || premium === false) {
      filterPremium = true;
    }

    // SAme tier or ftier is 0 (no value)
    if (ftier[curr.tier] || WarshipUtils.isEmpty(ftier)) {
      filterTier = true;
    }

    // Match or no value
    if (fnation[curr.nation] || WarshipUtils.isEmpty(fnation)) {
      filterNation = true;
    }

    // Match or no value
    if (ftype[curr.type] || WarshipUtils.isEmpty(ftype)) {
      filterType = true;
    }

    if (filterName && filterNation && filterPremium && filterTier && filterType)
      return true;
    return false;
  }

  static isEmpty(obj: {}) {
    return Object.keys(obj).length === 0;
  }

  static normalise(nation: any[], type: any[], tier: any[]) {
    let data = {nation: {}, type: {}, tier: {}};

    nation.forEach((i: any) => {
      data.nation[
        this.getKeyByValue(DATA[SAVED.encyclopedia].ship_nations, i)
      ] = true;
    });

    type.forEach((i: any) => {
      data.type[this.getKeyByValue(DATA[SAVED.encyclopedia].ship_types, i)] =
        true;
    });

    tier.forEach((i: any) => {
      data.tier[this.getTierList().indexOf(i) + 1] = true;
    });

    return data;
  }
}

export {WarshipUtils};
