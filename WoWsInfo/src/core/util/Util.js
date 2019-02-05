
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

export const dayDifference = (time) => {
  let given = new Date(time);
  let now = new Date();
  let timeDiff = Math.abs(now.getTime() - given.getTime());
  return Math.ceil(timeDiff / (1000 * 3600 * 24)); 
}