import React, { Component } from 'react';
import { StyleSheet, ScrollView, Text } from 'react-native';
import { View } from 'react-native-animatable';
import { PlayerInfo } from '../../core';
import { WoWsLoading, Basic8Cell, RecordCell, WoWsTouchable, SimpleBanner } from '../../component';
import { Divider } from 'react-native-elements';
import store from 'react-native-simple-store';
import language from '../../constant/language';
import { getTheme, getTextColour } from '../../constant/colour';
import { LocalData } from '../../constant/value';

class Basic extends Component {
  constructor(props) {
    super(props);
    this.state = {
      isReady: false, isMain: false,
      info: {}, record: [], weapon: []
    }
  }

  componentWillMount() {
    // Get data here
    const { id, name, server } = this.props;   
    let player = new PlayerInfo(name, id, server);
    player.Search().then(json => {
      let basic8Info = player.getBasic8Info(json);
      player.getPlayerBasicInfo(json).then(info => {     
        // Get average battle per day
        basic8Info.battle += ' (' + Math.round(parseFloat(basic8Info.battle) * 100 / parseFloat(info.created)) / 100 + ')';
        // Get record
        let recordInfo = player.getRecordInfo(json);
        // Get record weapon
        let recordWeaponInfo = player.getRecordWeaponInfo(json);
        var isMain = this.props.id == user_info.id;
        this.setState({
          isReady: true, isMain: isMain,
          info: Object.assign({}, info, basic8Info),
          record: recordInfo, weapon: recordWeaponInfo
        })        
      });
    })
  }

  render() {
    if (this.state.isReady) {
      const { id, name } = this.props;
      const { level, created, last_battle, rank, clan } = this.state.info;
      const { playerNameStyle, scrollViewStyle, mainViewStyle, playerInfoStyle, playerViewStyle, dontJudgeStyle } = styles;
      let color = getTheme();  
      let clanTag = clan == undefined ? '' : '[' + clan + ']\n';
      return (
        <View style={mainViewStyle} animation='fadeInUp'>
          <ScrollView style={scrollViewStyle} contentInset={{bottom: 50}}>
            <View style={[playerViewStyle, {backgroundColor: color}]}>
              <Text style={playerNameStyle}>{clanTag + name}</Text>
              <Text style={playerInfoStyle}>{last_battle}</Text>
              <Text style={playerInfoStyle}>{created + ' | Lv ' + level + ' | ⭐️' + rank}</Text>
              { this.renderSetAsMain() }             
            </View>
            <SimpleBanner />
            <Basic8Cell info={this.state.info}/>
            <Text style={dontJudgeStyle}>{language.player_respect}</Text>
            { this.renderRecord(this.state.record) }
            { this.renderRecord(this.state.weapon) }
          </ScrollView>
        </View>
      )
    } else return <WoWsLoading />
  }

  /**
   * Render Set as main account
   */
  renderSetAsMain() {
    if (this.state.isMain) return null; 
    else return (
      <WoWsTouchable onPress={() => {
        // Set as main account
        const { id, name, server } = this.props;
        user_info = {id: id, name: name, server: server};
        store.save(LocalData.user_info, user_info);
        this.setState({isMain: true});
      }}>
        <View><Text style={{fontSize: 16, color: getTextColour(getTheme())}}>{language.player_set_as_main}</Text></View>
      </WoWsTouchable>
    )
  }

  /**
   * Render player record
   * @param {*} data 
   */
  renderRecord(data) {
    return data.map((data, i) => {
      return (
        <View key={i}>
          <RecordCell info={data}/>          
        </View>
      )
    })
  }
}

const styles = StyleSheet.create({
  mainViewStyle: {
    flex: 1,
  },
  scrollViewStyle: {
    flex: 1,
  },
  playerViewStyle: {
    flex: 1,
    alignItems: 'center',
    justifyContent: 'center',
    marginBottom: 16,
    paddingBottom: 16
  },
  playerNameStyle: {
    textAlign: 'center',
    fontSize: 36,
    width: '100%',
    fontWeight: '400',
    margin: 16,
    color: 'white',
  },
  playerInfoStyle: {
    textAlign: 'center',
    fontSize: 18,
    width: '90%',
    fontWeight: '300',
    marginBottom: 8,
    color: 'white',    
  },
  setasmainViewStyle: {
    marginTop: 8,
    height: 32,
    width: '61.8%',
  },
  setasmainTextStyle: {
    fontSize: 18,
    textAlign: 'center',
    color: 'white'
  },
  dontJudgeStyle: {
    textAlign: 'center',
    fontSize: 14,
    fontWeight: '200',
    marginBottom: 2,
  }
})

export { Basic };