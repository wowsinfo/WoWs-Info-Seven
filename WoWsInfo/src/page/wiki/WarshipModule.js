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

class WarshipModule extends Component {
  constructor(props) {
    super(props);

    const { modules, modules_tree, ship_id } = props.data;
    console.log(modules, modules_tree, ship_id);

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
      torpedoes: ''
    };
  }

  render() {
    const { container } = styles;
    return (
      <WoWsInfo>

      </WoWsInfo>
    )
  };

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
      if (json) {
        setTimeout(() => {
          Actions.refresh({module: json});
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
