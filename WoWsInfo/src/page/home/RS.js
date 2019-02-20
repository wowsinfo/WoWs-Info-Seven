import React, { Component } from 'react';
import { View, ScrollView, StyleSheet, KeyboardAvoidingView, Linking, Alert, FlatList } from 'react-native';
import { isAndroid } from 'react-native-device-detection';
import { Portal, TextInput, Button, Dialog, List, Text, Title } from 'react-native-paper';
import { WoWsInfo, LoadingIndicator, Touchable, WarshipCell, SimpleRating, RatingButton } from '../../component';
import { SafeFetch, roundTo, Guard, getOverallRating, SafeAction, SafeValue } from '../../core';
import { WoWsAPI } from '../../value/api';
import { getCurrDomain, SAVED } from '../../value/data';

class RS extends Component {
  constructor(props) {
    super(props);

    this.state = {
      // Controls whether ip if valid
      ip: '',
      rs: null,
      valid: false,
      // Whether show map info
      info: false,
      // Whether we are loading player info
      loading: true,
      battleTime: '',
      // array is player list and Info is for each team (winrate, damage and so on)
      allay: [],
      allayInfo: {},
      enemy: [],
      enemyInfo: {}
    };

    this.domain = getCurrDomain();
  }

  render() {
    const { container, input } = styles;
    const { ip, rs, valid } = this.state;
    return (
      <WoWsInfo onPress={rs ? () => this.setState({info: true}) : null} title='Map Information'>
        { !valid ? <KeyboardAvoidingView style={container} behavior='padding' enabled>
          <TextInput style={input} theme={{roundness: 0}} value={ip} placeholder='192.168.1.x' 
            keyboardType={isAndroid ? 'decimal-pad' : 'numbers-and-punctuation'}
            onChangeText={t => this.setState({ip: t})}
            onEndEditing={() => this.validIP(ip)}/>
          <Button uppercase={false} onPress={() => Linking.openURL('https://github.com/HenryQuan/WoWs-RS/releases/latest')}>
            Download RS on your computer
          </Button>
        </KeyboardAvoidingView> : this.renderPlayer() }
        { this.renderMapInfo(rs) }
      </WoWsInfo>
    )
  };

  renderPlayer() {
    const { loading, allay, enemy } = this.state; 
    if (loading) return <LoadingIndicator />;
    
    const { horizontal } = styles;
    let allayRating = getOverallRating(allay);
    let enemyRating = getOverallRating(enemy);
    allay.sort((a, b) => b.ap - a.ap);
    enemy.sort((a, b) => b.ap - a.ap);
    
    return (
      <ScrollView>
        <View style={[horizontal, {justifyContent: 'space-between'}]}>
          <RatingButton rating={allayRating} number/>
          <Title>RS Beta</Title>
          <RatingButton rating={enemyRating} number/>
        </View>
        <View style={horizontal}>
          <FlatList data={allay} renderItem={({item}) => this.renderPlayerCell(item)}
            keyExtractor={p => String(p.account_id)} style={{margin: 8}}/>
          <FlatList data={enemy} renderItem={({item}) => this.renderPlayerCell(item)}
            keyExtractor={p => String(p.account_id)} style={{margin: 8}}/>
        </View>
      </ScrollView>
    );
  }

  renderPlayerCell(info) {
    const { playerName, cell } = styles;
    const { nickname, name } = info;
    let pName = SafeValue(nickname, name);
    return (
      <Touchable style={cell} onPress={info.pvp ? () => SafeAction('PlayerShipDetail', {data: info}) : null}>
        <WarshipCell item={DATA[SAVED.warship][info.ship_id]} scale={1.4}/>
        <Text style={playerName} numberOfLines={1}>{pName}</Text>
        <SimpleRating info={info}/>
      </Touchable>
    );
  }

  renderMapInfo(rs) {
    if (rs === null) return null;
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
    let url = 'http://' + ip.split('/').join('') + ':8605';
    fetch(url).then(html => html.text()).then(text => {
      if (text === '[]') throw 'Unkown error';
      this.setState({valid: true});
      this.getArenaInfo(url);
      this.interval = setInterval(() => this.getArenaInfo(url), 22222);
    }).catch(() => Alert.alert('Error', `${url} is not valid`));
  }

  getArenaInfo(url) {
    fetch(url).then(html => html.text()).then(text => {
      if (text === '[]') throw 'Data is not valid';

      const data = JSON.parse(text);
      this.setState({rs: data});
      const { battleTime } = this.state;
      // Make sure it is a new date
      if (data.dateTime !== battleTime) {
        this.setState({loading: true, battleTime: data.dateTime});
        const vehicles = data.vehicles;
        // Get allay and enemy
        let allayList = [];
        let enemyList = [];
        vehicles.forEach((v, i) => {
          setTimeout(() => this.appendExtraInfo(v).then(player => {
            const team = player.relation;
            // 0 and 1 are friends
            if (team < 2) allayList.push(player);
            else enemyList.push(player);
  
            // Update data here
            if (i === vehicles.length - 1) {
              this.setState({
                allay: allayList,
                enemy: enemyList,
                loading: false
              });
            }
          }), 300);
        });
      }
    }).catch(() => {
      // Some error so no longer valid
      clearTimeout(this.interval);
      this.setState({valid: false, ip: '', rs: null});
    });
  }

  async appendExtraInfo(player) {
    const { name, shipId } = player;
    if (name.startsWith(':')) return player;
    let idInfo = await SafeFetch.get(WoWsAPI.PlayerSearch, this.domain, name);
    let playerID = Guard(idInfo, 'data.0', null);
    if (playerID != null) {
      player.ship_id = player.shipId;
      delete player.shipId; delete player.id; delete player.name;
      player.account_id = playerID.account_id;
      player.nickname = playerID.nickname;

      // Get player ship info
      let shipInfo = await SafeFetch.get(WoWsAPI.OneShipInfo, this.domain, shipId, player.account_id);
      let pvp = Guard(shipInfo, `data.${player.account_id}.0.pvp`, null);
      if (pvp != null) {
        player.pvp = pvp;
      }
    }
    return player;
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
  },
  horizontal: {
    flexDirection: 'row',
    padding: 8
  },
  playerName: {
    fontWeight: '300',
    fontSize: 17,
    marginBottom: 8,
    textAlign: 'center'
  },
  cell: {
    margin: 4
  }
});

export { RS };
