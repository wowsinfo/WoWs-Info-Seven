
export const getTierLabel = (tier) => {
  if (tier < 1) return 'O';
  // From 1 to 15
  const label = getTierList();
  return label[tier - 1];
}

/**
 * A function that returns a colour between red and green depending on curr / max
 */
export const getColourWithRange = (min, curr, max) => {
  if (curr < min) return '#FF0000';
  let scale = Number((curr - min) / (max - min) * 100).toFixed(0);

  function componentToHex(c) {
    let hex = c.toString(16);
    hex = hex.substring(0, 2);
    return hex.length == 1 ? "0" + hex : hex;
  }

  function rgbToHex(r, g, b) {
      return "#" + componentToHex(r) + componentToHex(g) + componentToHex(b);
  }

  let G = (255 * scale) / 100;
  let R = (255 * (100 - scale)) / 100;
  let colour = rgbToHex(R, G, 0);
  console.log(colour);
  return colour;
}

export const getKeyByValue = (object, value) => {
  return Object.keys(object).find(key => object[key] === value);
}

export const getTierList = () => {
  return ['I', 'II', 'III', 'IV', 'V', 'VI', 'VII', 'VIII', 'IX', 'X'];
}