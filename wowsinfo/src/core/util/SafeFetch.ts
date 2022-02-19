import {SafeValue} from './SafeGuard';

class SafeFetch {
  /**
   * Make sure language is at the end
   * @param {*} api
   * @param  {...any} extra
   */
  static get(api: string, ...extra: string[]) {
    const format = require('string-format');
    let lang = extra.pop() || '';
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
   * @param {*} api the url link
   */
  static normal(api: string) {
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
