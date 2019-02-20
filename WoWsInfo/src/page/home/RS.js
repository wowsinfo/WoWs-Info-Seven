import React, { Component } from 'react';
import { ScrollView, StyleSheet, KeyboardAvoidingView, Linking } from 'react-native';
import { isAndroid } from 'react-native-device-detection';
import { Portal, TextInput, Button, Dialog, List, Text } from 'react-native-paper';
import { WoWsInfo, LoadingIndicator } from '../../component';
import { SafeFetch, roundTo, Guard, getOverallRating } from '../../core';
import { WoWsAPI } from '../../value/api';
import { getCurrDomain } from '../../value/data';

class RS extends Component {
  constructor(props) {
    super(props);

    this.state = {
      ip: '192.168.1.105',
      rs: require('../../coop.json'),
      info: false,

      loading: true,
      allay: [],
      allayInfo: {},
      enemy: [],
      enemyInfo: {}
    };

    this.domain = getCurrDomain();
  }

  render() {
    const { container, input } = styles;
    const { ip, rs } = this.state;
    return (
      <WoWsInfo onPress={() => this.setState({info: true})} title='Map Information'>
        { ip === '' ? <KeyboardAvoidingView style={container} behavior='padding' enabled>
          <TextInput style={input} theme={{roundness: 0}} value={ip} placeholder='192.168.1.x' 
            keyboardType={isAndroid ? 'decimal-pad' : 'numbers-and-punctuation'}
            onChangeText={t => this.setState({ip: t})}
            onEndEditing={() => this.validIP(ip)}/>
          <Button uppercase={false} onPress={() => Linking.openURL('https://github.com/HenryQuan/WoWs-RS/releases/latest')}>
            Download RS on your computer
          </Button>
        </KeyboardAvoidingView> : this.renderPlayer(rs) }
        { this.renderMapInfo(rs) }
      </WoWsInfo>
    )
  };

  renderPlayer(rs) {
    const { vehicles } = rs;

    // Get allay and enemy
    let allayList = [];
    let enemyList = [];
    vehicles.forEach((v, i) => {
      setTimeout(() => this.appendExtraInfo(v).then(() => {
        const team = v.relation;
        console.log(v);
        // 0 and 1 are friends
        if (team < 2) allayList.push(v);
        else enemyList.push(v);

        // Update data here
        if (i === vehicles.length - 1) {
          let allayRating = getOverallRating(allayList);
          let enemyRating = getOverallRating(enemyList);
          this.setState({
            allay: allayList,
            enemy: enemyList,
            loading: false
          });
        }
      }), 300);
    });

    const { loading, allay, enemy } = this.state; 
    if (loading) return <LoadingIndicator />;
    return (
      <Text>{JSON.stringify(allay)}</Text>
    );
  }

  async appendExtraInfo(player) {
    const { name, shipId } = player;
    if (name.startsWith(':')) return;
    let idInfo = await SafeFetch.get(WoWsAPI.PlayerSearch, this.domain, name);
    let playerID = Guard(idInfo, 'data.0', null);
    if (playerID != null) {
      player.account_id = playerID.account_id;
      player.nickname = playerID.nickname;

      // Get player ship info
      let shipInfo = await SafeFetch.get(WoWsAPI.OneShipInfo, this.domain, shipId, player.account_id);
      let pvp = Guard(shipInfo, `data.${player.account_id}.0.pvp`, null);
      if (pvp != null) {
        player.pvp = pvp;
      }
    }
  }

  renderMapInfo(rs) {
    const { info } = this.state;

    const { clientVersionFromExe, dateTime, duration, gameLogic,
      mapDisplayName, matchGroup, name, weatherParams } = rs;
    let params = '';
    for (let ID in weatherParams) {
      let curr = weatherParams[ID].join(', ');
      params += curr + '\n';
    }

    return (
      <Portal>
        <Dialog visible={info} dismissable={true} theme={{roundness: 16}}
          style={{maxHeight: '61.8%'}} onDismiss={() => this.setState({info: false})}>
          <ScrollView showsVerticalScrollIndicator={false}>
            <List.Item title='Client Version' description={clientVersionFromExe} />
            <List.Item title='Time' description={dateTime} />
            <List.Item title='Game Mode' description={`${matchGroup} - ${gameLogic} - ${name}`} />
            <List.Item title='Map' description={mapDisplayName} />
            <List.Item title='Duration' description={`${roundTo(duration / 60)} min`} />
            <Text style={{paddingLeft: 16}}>{params}</Text>
          </ScrollView>
        </Dialog>
      </Portal>
    );
  }

  /**
   * Check the IP format and try to send a request to it
   * @param {string} ip 
   */
  validIP(ip) {
    let url = ip.split('/').join('') + ':8605';
    SafeFetch.normal(url).then(data => {
      if (data.length !== 0) {
        this.setState({rs: data});
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
  input: {
    width: '100%',
    marginBottom: 8
  }
});

export { RS };
