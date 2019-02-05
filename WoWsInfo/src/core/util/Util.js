
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
  let obj = new Date(time * 1000);
  // first part to get date string and the second get locale time
  return `${obj.toISOString().slice(0, 10)} ${obj.toLocaleTimeString()}`;
}