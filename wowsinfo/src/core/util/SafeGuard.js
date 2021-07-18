/**
 * Get to path of obj and return its value or return default value
 * @param {*} obj
 * @param {string} path
 * @param {*} dval
 */
export const Guard = (obj, path, dval) => {
  // This is a just a simple check if obj is null or undefined
  if (path === '' && obj != null) return obj;
  // check if object is valid and path does not start with or end with '.'
  if (!path.startsWith('.') && !path.endsWith('.')) {
    // get path as an array and it must have at least 2 elements
    let p = path.split('.');
    if (p && p.length > 0) {
      // o is the object (accumulator), and n is from path (current value)
      // o && o[n] -> to go further or just return default value
      // only asking for the object
      return p.reduce((o, n) => (o != null && o[n] != null ? o[n] : dval), obj);
    }
  }
  return dval;
};

/**
 * Return a default value if obj is not valid
 * @param {*} obj
 * @param {*} dval
 */
export const SafeValue = (obj, dval) => {
  if (obj == null) return dval;
  return obj;
};
