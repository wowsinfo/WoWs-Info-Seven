import React, {Component} from 'react';
import {
  View,
  ScrollView,
  StyleSheet,
  KeyboardAvoidingView,
  Linking,
  Alert,
  Vibration,
} from 'react-native';
import {isAndroid, isTablet} from 'react-native-device-detection';
import {
  Portal,
  TextInput,
  Button,
  Dialog,
  List,
  Text,
  Title,
} from 'react-native-paper';
import {
  WoWsInfo,
  LoadingIndicator,
  Touchable,
  WarshipCell,
  SimpleRating,
  RatingButton,
} from '../../component';
import {
  SafeFetch,
  roundTo,
  Guard,
  getOverallRating,
  SafeAction,
  SafeValue,
  SafeStorage,
  random,
} from '../../core';
import {WoWsAPI} from '../../value/api';
import {
  getCurrDomain,
  SAVED,
  LOCAL,
  getCurrServer,
  setLastLocation,
} from '../../value/data';
import {FlatGrid} from 'react-native-super-grid';
import {lang} from '../../value/lang';
import KeepAwake from 'react-native-keep-awake';

class RS extends Component {
  constructor(props) {
    super(props);
    setLastLocation('RS');
    this.state = {
      // Controls whether ip if valid
      ip: DATA[LOCAL.rsIP], // load saved ip
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
      enemyInfo: {},
    };

    this.domain = getCurrDomain();
  }

  componentDidMount() {
    const {ip} = this.state;
    KeepAwake.activate();
    // Enter rs mode when there is a valid ip
    if (ip !== '') this.validIP(ip);
  }

  componentWillUnmount() {
    KeepAwake.deactivate();
  }

  render() {
    const {container, input} = styles;
    const {ip, rs, valid} = this.state;

    return (
      <WoWsInfo
        onPress={rs ? () => this.setState({info: true}) : null}
        title="Map Information">
        {!valid ? (
          <KeyboardAvoidingView style={container} behavior="padding" enabled>
            <TextInput
              style={input}
              theme={{roundness: 0}}
              value={ip}
              placeholder="192.168.1.x"
              keyboardType={
                isAndroid ? 'decimal-pad' : 'numbers-and-punctuation'
              }
              onChangeText={t => this.setState({ip: t})}
              onEndEditing={() => this.validIP(ip)}
            />
            <Button
              uppercase={false}
              onPress={() =>
                Linking.openURL(
                  'https://github.com/HenryQuan/WoWs-RS/releases/latest',
                )
              }>
              {lang.extra_rs_beta_download}
            </Button>
          </KeyboardAvoidingView>
        ) : (
          this.renderPlayer()
        )}
        {this.renderMapInfo(rs)}
      </WoWsInfo>
    );
  }

  renderPlayer() {
    const {loading, allay, enemy} = this.state;
    if (loading) return <LoadingIndicator />;

    const {horizontal} = styles;
    let allayRating = getOverallRating(allay);
    let enemyRating = getOverallRating(enemy);
    allay.sort((a, b) => b.ap - a.ap);
    enemy.sort((a, b) => b.ap - a.ap);

    return (
      <ScrollView>
        <View style={[horizontal, {justifyContent: 'space-between'}]}>
          <RatingButton rating={allayRating} number />
          <Title>RS Beta</Title>
          <RatingButton rating={enemyRating} number />
        </View>
        <View style={horizontal}>
          <FlatGrid
            data={allay}
            itemDimension={120}
            renderItem={({item}) => this.renderPlayerCell(item)}
            keyExtractor={p => String(p.account_id)}
            style={{margin: 8, width: '50%'}}
          />
          <FlatGrid
            data={enemy}
            itemDimension={120}
            renderItem={({item}) => this.renderPlayerCell(item)}
            keyExtractor={p => String(p.account_id)}
            style={{margin: 8, width: '50%'}}
          />
        </View>
      </ScrollView>
    );
  }

  renderPlayerCell(info) {
    const {playerName, cell} = styles;
    const {nickname, name} = info;
    let pName = SafeValue(nickname, name);
    // For pushing to player
    info.server = getCurrServer();
    return (
      <Touchable
        style={cell}
        onPress={
          info.pvp ? () => SafeAction('PlayerShipDetail', {data: info}) : null
        }
        onLongPress={
          info.account_id ? () => SafeAction('Statistics', {info: info}) : null
        }>
        <WarshipCell item={DATA[SAVED.warship][info.ship_id]} scale={1.4} />
        <Text style={playerName} numberOfLines={1}>
          {pName}
        </Text>
        <SimpleRating info={info} />
      </Touchable>
    );
  }

  renderMapInfo(rs) {
    if (rs === null) return null;
    const {info} = this.state;

    const {
      clientVersionFromExe,
      dateTime,
      duration,
      gameLogic,
      mapDisplayName,
      matchGroup,
      name,
      weatherParams,
    } = rs;
    let params = '';
    for (let ID in weatherParams) {
      let curr = weatherParams[ID].join(', ');
      params += curr + '\n';
    }

    return (
      <Portal>
        <Dialog
          visible={info}
          dismissable={true}
          theme={{roundness: 16}}
          style={{maxHeight: '61.8%'}}
          onDismiss={() => this.setState({info: false})}>
          <ScrollView showsVerticalScrollIndicator={false}>
            <List.Item
              title="Client Version"
              description={clientVersionFromExe}
            />
            <List.Item title="Time" description={dateTime} />
            <List.Item
              title="Game Mode"
              description={`${matchGroup} - ${gameLogic} - ${name}`}
            />
            <List.Item title="Map" description={mapDisplayName} />
            <List.Item
              title="Duration"
              description={`${roundTo(duration / 60)} min`}
            />
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
  async validIP(ip) {
    let url = 'http://' + ip.split('/').join('') + ':8605';
    try {
      // Only want to know if we can access it
      await fetch(url);
      this.setState({valid: true}, () => {
        // Update IP when it is valid
        SafeStorage.set(LOCAL.rsIP, ip);
      });
      this.getArenaInfo(url);
      this.interval = setInterval(() => this.getArenaInfo(url), 22222);
    } catch {
      Alert.alert('Error', `${url} is not valid`);
    }
  }

  async getArenaInfo(url) {
    try {
      let text = await fetch(url).then(html => html.text());
      if (text !== '[]') {
        const data = JSON.parse(text);
        this.setState({rs: data});
        const {battleTime} = this.state;
        // Make sure it is a new date
        if (data.dateTime !== battleTime) {
          this.setState({loading: true, battleTime: data.dateTime});
          const vehicles = data.vehicles;
          // Get allay and enemy
          let allayList = [];
          let enemyList = [];
          for (let v of vehicles) {
            setTimeout(() => {
              this.appendExtraInfo(v).then(player => {
                const team = player.relation;
                // 0 and 1 are friends
                if (team < 2) allayList.push(player);
                else enemyList.push(player);

                // Set a random id (1 in 88888888 is really small but it can happens)
                if (player.account_id == null)
                  player.account_id = random(88888888);

                this.setState({
                  allay: allayList,
                  enemy: enemyList,
                  loading: false,
                });
              });
            }, 300);
          }
        }
      }
    } catch {
      // Some error so no longer valid
      clearTimeout(this.interval);
      this.setState({valid: false, rs: null});
    }
  }

  async appendExtraInfo(player) {
    const {name, shipId} = player;
    if (name.startsWith(':')) return player;
    let idInfo = await SafeFetch.get(WoWsAPI.PlayerSearch, this.domain, name);
    let playerID = Guard(idInfo, 'data.0', null);
    if (playerID != null) {
      player.ship_id = player.shipId;
      delete player.shipId;
      delete player.id;
      delete player.name;
      player.account_id = playerID.account_id;
      player.nickname = playerID.nickname;

      // Get player ship info
      let shipInfo = await SafeFetch.get(
        WoWsAPI.OneShipInfo,
        this.domain,
        shipId,
        player.account_id,
      );
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
    justifyContent: 'center',
  },
  input: {
    width: '100%',
    marginBottom: 8,
  },
  horizontal: {
    flexDirection: 'row',
    padding: 8,
  },
  playerName: {
    fontWeight: '300',
    fontSize: 17,
    marginBottom: 8,
    textAlign: 'center',
  },
  cell: {
    margin: 4,
  },
});

export {RS};
