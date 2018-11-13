let temp = require('./temp.json');
let fs = require('fs');
let request = require('request');
let fetch = require('node-fetch');
let jsdom = require("jsdom");
const { JSDOM } = jsdom;

let copy = Object.assign(temp);
for (let id in copy) {
  let curr = copy[id];
  let name = curr.name;
  if (name[0] === '[') {
    delete copy[id];
    continue;
  }
  // Change space to _
  name = name.split(' ').join('_');
  let link = 'http://wiki.wargaming.net/en/Ship:' + name;
  setTimeout(() => {
    // Download webpage and get the string we need
    fetch(link).then(res => res.text()).then(html => {
      console.log(link);
      const dom = new JSDOM(html);
      const model = dom.window.document.querySelector('.Model3D').textContent;
      if (model) {
        curr.model = model;
        console.log(model);
        fs.writeFile('test.json', JSON.stringify(copy), err => {
          if (err) throw err;
          console.log('complete');
        });
      }
    }).catch(err => console.error(err));
  }, 100);
}