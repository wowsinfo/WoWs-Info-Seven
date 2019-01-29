/**
 * Only print when it is debuging mode
 * @param {*} msg 
 */
export const DLOG = (msg) => {
  if (__DEV__) console.log(msg);
}

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