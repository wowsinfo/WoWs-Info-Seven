class SafeGuard {
  /**
   * Get to path of obj and return its value or return default value
   * @param {*} obj the nested object
   * @param {*} path a string path like sample.value
   * @param {*} dval default value
   * @returns dval or the value
   */
  static get(obj: any, path: string, dval: any) {
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
        return p.reduce(
          (o, n) => (o != null && o[n] != null ? o[n] : dval),
          obj,
        );
      }
    }
    return dval;
  }

  /**
   * Return a default value if obj is not valid
   * @param obj the object
   * @param dval default value
   * @returns dval or obj
   */
  static value(obj: any, dval: any) {
    if (obj == null) return dval;
    return obj;
  }
}

export {SafeGuard};
