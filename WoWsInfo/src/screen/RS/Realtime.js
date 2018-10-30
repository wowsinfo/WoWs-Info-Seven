import React, { Component } from 'react';
import { View, Text, StyleSheet, ScrollView } from 'react-native';
import GridView from 'react-native-super-grid';
import { Divider } from 'react-native-elements';
import { ShipInfo, PlayerSearch } from '../../core';
import { API } from '../../constant/value';
import sample from '../../local.json';
import { ShipInfoCell, WoWsLoading } from '../../component/';
import { Language } from '../../core';
import { navStyle } from '../../constant/colour';
import { iconsMap } from '../../constant/icon';

export default class Realtime extends Component {
  static navigatorStyle = {
    tabBarHidden: true
  }

  async componentWillMount() {
    const { vehicles } = sample;
    // We need to get user id and then get user stat for shipId
    let playerList = []
    for (let player of vehicles) {
      const { shipId, relation, name } = player;
      if (!name.startsWith(':')) {
        let player = new PlayerSearch(global.server, name);
        let playerData = await player.Search();
        if (playerData) {
          let id = playerData[0].id;
          let ship = new ShipInfo(`${id}&ship_id=${shipId}`, global.server);
          let shipData = await ship.getShipInfo();
          if (shipData[0]) {
            let curr = Object.assign(shipData[0]);
            console.log(curr);
            curr.id = id;
            curr.name = name;
            curr.server = global.server;
            playerList.push(curr);
          }
        }
      }
    }

    // Sort by AP
    playerList.sort((x, y) => {
      return y.ap - x.ap;
    })

    this.setState({list: playerList});
  }

  render() {
    const { container } = styles;
    return (
      <View style={container}>
        { this.renderBasicInfo(sample) }
        { this.renderPlayers() }
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
    const { basicInfo } = styles;
    console.log(this.state);
    if (this.state) {
      return (
        <ScrollView>
          <GridView itemDimension={256} items={this.state.list} renderItem={item => {
            return <ShipInfoCell detail={this.pushToPlayer} info={item}/>
          }}/>
        </ScrollView>
      )
    } else return <WoWsLoading />
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

  pushToPlayer = (item) => {
    this.props.navigator.push({
      title: String(item.id),
      screen: 'search.player',
      backButtonTitle: '',              
      navigatorStyle: navStyle(),
      navigatorButtons: item.id == user_info.id ? null : {
        rightButtons: friend.find(x => x.id === item.id) 
          ? [{icon: iconsMap['star'], id: 'star-o'}]
          : [{icon: iconsMap['star-o'], id: 'star'}]
      },
      passProps: item
    })
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
    textAlign: 'center',
    width: '100%',
    fontWeight: '500'
  }
})