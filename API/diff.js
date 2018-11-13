let model = require('./model.json');

for (let id in model) {
  let curr = model[id];
  let name = curr.name.split(' ').join('_');
  if (!curr.model) {
    console.log(name);
  }
}