import {SafeValue} from './SafeGuard';

class SafeFetch {
  /**
   * Make sure language is at the end
   * @param {*} api
   * @param  {...any} extra
   */
  static get(api, ...extra) {
    const format = require('string-format');
    let lang = '';
    if (extra.length > 1) lang = extra.pop();
    let link = format(api, ...extra) + lang;
    console.log(`SafeFetch\n${link}`);
    return fetch(link)
      .then(res => {
        // To make sure request is valid
        if (res.status === 200) return res.json();
      })
      .then(json => {
        if (json && json.status === 'ok') return json;
        else return {};
      });
  }

  /**
   * A simple wrapper around fetch api
   * @param {*} api
   */
  static normal(api) {
    console.log(`NormalFetch\n${api}`);
    return fetch(api)
      .then(res => {
        // To make sure request is valid
        if (res.status === 200) return res.json();
      })
      .then(json => {
        return SafeValue(json, {});
      })
      .catch(err => console.error(err));
  }
}

export {SafeFetch};
