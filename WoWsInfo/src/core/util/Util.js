import { lang } from "../../value/lang";

/**
 * Deep clone an object
 * @param {*} value 
 */
export const copy = (value) => {
  return JSON.parse(JSON.stringify(value));
}

/**
 * Return a number between 0 to range - 1
 * @param {int} range 
 */
export const random = (range) => {
  return Math.floor(Math.random() * range);
}

export const roundTo = (num, digit = 0) => {
  if (isNaN(num) || !isFinite(num)) return Number(-1);
  return Number(num).toFixed(digit);
}

/**
 * Get date difference in days
 * @param {*} time 
 */
export const dayDifference = (time) => {
  let timeDiff = Math.abs(Date.now() / 1000 - time);
  return Math.ceil(timeDiff / (3600 * 24)); 
}

/**
 * Get a readable date string
 * @param {*} time 
 */
export const humanTimeString = (time) => {
  if (time == null) return lang.warship_unkown;
  if (time === 0) return `---`;
  let obj = new Date(time * 1000);
  // first part to get date string and the second get locale time
  return `${obj.toISOString().slice(0, 10).split('-').join('.')} ${obj.toLocaleTimeString()}`;
}
