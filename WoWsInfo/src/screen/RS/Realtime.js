import React, { Component } from 'react';
import { View, Text, StyleSheet } from 'react-native';
import GridView from 'react-native-super-grid';
import { Divider } from 'react-native-elements';
import {API} from '../../constant/value';
import sample from '../../local.json';
import { WoWsTouchable } from '../../component/';
import { Language } from '../../core';

export default class Realtime extends Component {
  static navigatorStyle = {
    tabBarHidden: true
  }

  state = {
    mode: '',
  }

  render() {
    const { container } = styles;
    return (
      <View style={container}>
        { this.renderBasicInfo(sample) }
        { this.renderPlayers(sample) }
      </View>
    )
  }

  /**
   * Render basic map information
   * @param {*} data 
   */
  renderBasicInfo(data) {
    const { duration, gameLogic, mapDisplayName,
      name, matchGroup, playerName, playerVehicle, } = data;
    const { basicInfo, logic } = styles;

    let min = duration / 60;
    let ship = playerVehicle.split('-').pop();
    let map = mapDisplayName.split('_').slice(2).join(' ').toUpperCase();

    return (
      <View style={basicInfo}>
        <Text style={logic}>{gameLogic}</Text>
        <Text>{map}</Text>
        <Text>{name}</Text>
        <Text>---</Text>
        <Text>{matchGroup}</Text>
        <Text>{`${min} min`}</Text>
        <Text>---</Text>

        <Text>{playerName}</Text>
        <Text>{ship}</Text>
      </View>
    )
  }

  renderPlayers(data) {
    const { vehicles } = data;
    const { basicInfo } = styles;
    return (
      <View style={basicInfo}>
        <GridView itemDimension={256} items={vehicles} renderItem={item => {
        const { shipId, relation, name } = item;
        return (
          <WoWsTouchable onPress={() => null}>
            <Text style={{color: relation < 2 ? 'green' : 'red'}}>{`${shipId} ${relation} ${name}`}</Text>
          </WoWsTouchable>
        )}}/>
      </View>
    )
  }

  /**
   * Get All gamemode and their info
   */
  getGameMode() {
    var format = require('string-format');
    var api = format(API.GameMode, global.domain) + Language.getApiLangStr();
    console.log(api);
    return fetch(api).then(res => {
      if (res.status === 200) return res.json();
    }).catch(error => console.error(error));
  }
}

const styles = StyleSheet.create({
  container: {
    flex: 1
  },
  basicInfo: {
    marginTop: 8,
    alignItems: 'center',
  },
  logic: {
    fontSize: 32,
    fontWeight: '500'
  }
})