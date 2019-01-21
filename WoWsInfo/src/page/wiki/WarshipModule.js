/**
 * WarshipModule.js
 * 
 * 
 */

import React, { Component } from 'react';
import { View, ScrollView, StyleSheet } from 'react-native';
import { WoWsInfo, PriceLabel } from '../../component';
import { SafeFetch, langStr, getCurrServer } from '../../core';
import { WoWsAPI } from '../../value/api';
import { Actions } from 'react-native-router-flux';
import { SAVED } from '../../value/data';
import { SectionGrid } from 'react-native-super-grid';
import { ThemeBackColour } from '../../value/colour';
import { List, Text, Caption } from 'react-native-paper';

class WarshipModule extends Component {
  constructor(props) {
    super(props);

    const { ship_id, modules_tree } = props.data;
    this.server = getCurrServer();

    this.state = {
      ship_id: ship_id,
      artillery: '',
      dive_bomber: '',
      engine: '',
      fighter: '',
      fire_control: '',
      flight_control: '',
      hull: '',
      torpedo_bomber: '',
      torpedoes: '',
      tree: modules_tree,
      // Data needed for section grid
      section: this.makeSection(props.data)
    };
  }

  render() {
    const {  } = styles;
    const { section, tree } = this.state;
    return (
      <WoWsInfo>
        <ScrollView invert>
          { 
            section.map(s => {
              return (
                <View key={s.title}>
                  <List.Section title={s.title}>
                    { s.data.map(d => {
                      return this.renderModule(tree[d]);
                    }) }
                  </List.Section>
                </View>
              );
            })
          }
        </ScrollView>
      </WoWsInfo>
    )
  };

  renderModule(item) {
    if (!item) return null;
    const { name, price_xp, price_credit } = item;
    const { xp } = styles;
    return (
      <List.Item title={name} description={price_credit}
        right={() => price_xp > 0 ? <Caption style={xp}>{`${price_xp} xp`}</Caption> : null}/>
    );
  }

  makeSection(data) {
    const { modules, modules_tree } = data;

    let moduleName = DATA[SAVED.encyclopedia].ship_modules;

    let section = [];
    for (let key in modules) {
      let curr = modules[key];
      if (curr.length > 1) {
        // Ignore empty or one module, you cannot update them anyway
        let sorted = curr.sort((a, b) => {
          let aXP = modules_tree[a].price_xp;
          let bXP = modules_tree[b].price_xp;
          // Sort by XP (more xp, more advanced)
          return modules_tree[a].price_xp - modules_tree[b].price_xp;
        });
        let obj = {title: moduleName[this.normaliseKey(key)], data: sorted};
        section.push(obj);
      }
    }
    return section;
  }

  /**
   * hello_world becomes HelloWorld
   * @param {*} key 
   */
  normaliseKey(key) {
    let names = key.split('_');
    upperFirst = (str) => str.charAt(0).toUpperCase() + str.slice(1);
    names.map((n, i) => names[i] = upperFirst(n));

    console.log(names);
    let name = names.join('');
    // Seriously??
    if (name === 'FireControl') name = 'Suo';
    return name;
  }

  getNewModule() {
    const {
      ship_id,
      artillery,
      dive_bomber,
      engine,
      fighter,
      fire_control,
      flight_control,
      hull,
      torpedo_bomber,
      torpedoes
    } = this.state;

    SafeFetch.get(WoWsAPI.ShipModule, this.server, ship_id, artillery, dive_bomber, engine, fighter, 
      fire_control, flight_control, hull, torpedo_bomber, torpedoes, langStr()).then(json => {
      Actions.popTo('WarshipDetail');
      if (json && json.data[ship_id]) {
        // Just pass profile back (override default_profile)
        setTimeout(() => {
          Actions.refresh({module: json.data[ship_id]});
        })
      } else {
        // Error
      }
    });
  }
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    alignItems: 'center',
    justifyContent: 'center'
  },
  xp: {
    paddingRight: 4,
    alignSelf: 'center'
  }
});

export { WarshipModule };
