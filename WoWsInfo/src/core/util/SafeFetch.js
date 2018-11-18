class SafeFetch {
  static get(api, server, extra='') {
    const format = require('string-format');
    let link = format(api, server) + extra;
    console.log(`SafeFetch\n${link}`);
    return fetch(link).then(res => {
      // To make sure request is valid
      if (res.status === 200) return res.json();
      else return null;
    }).then(json => {
      if (json && json.status === 'ok') return json;
    });
  }
}

export { SafeFetch };
