/**
 * WarshipModule.js
 * 
 * 
 */

import React, { Component } from 'react';
import { View, Text, StyleSheet } from 'react-native';
import { WoWsInfo } from '../../component';
import { SafeFetch, langStr, getCurrServer } from '../../core';
import { WoWsAPI } from '../../value/api';
import { Actions } from 'react-native-router-flux';
import { SAVED } from '../../value/data';
import { SectionGrid } from 'react-native-super-grid';
import { ThemeBackColour } from '../../value/colour';
import { List } from 'react-native-paper';

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
        <SectionGrid itemDimension={320} sections={section} renderItem={({item}) => {
          return <Text>{tree[item].name}</Text>
        }} renderSectionHeader={({section}) => (
          <List.Item title={section.title} style={ThemeBackColour()}/>
        )}/>
      </WoWsInfo>
    )
  };

  makeSection(data) {
    const { modules } = data;

    let moduleName = DATA[SAVED.encyclopedia].ship_modules;

    let section = [];
    for (let key in modules) {
      let curr = modules[key];
      if (curr.length > 1) {
        // Ignore empty or one module, you cannot update them anyway
        let obj = {title: moduleName[this.normaliseKey(key)], data: curr.reverse()};
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
  }
});

export { WarshipModule };
