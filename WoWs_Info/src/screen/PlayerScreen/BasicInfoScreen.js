import React from 'react';
import { Basic8Cell, WoWsLoading } from '../../component';
import { View, ScrollView, Text } from 'react-native';
import { Divider } from 'react-native-elements';
import { WoWsTouchable, RecordCell } from '../../component';
import store from 'react-native-simple-store';
import { PlayerInfo } from '../../core';
import { localDataName } from '../../constant/value';
import { styles } from './BasicInfoScreenStyles';
import strings from '../../localization';

class BasicInfoScreen extends React.PureComponent {
  constructor(props) {
    super();
    this.state = {
      isReady: false,
      info: {},
      record: [],
      weapon: [],
      isMainAccount: false,
    }
  }

  componentWillMount() {
    // Get data here
    const { id, playerName, server } = this.props;   
    let player = new PlayerInfo(playerName + '|' + id + '|' + server);
    player.Search().then(json => {
      let basic8Info = player.getBasic8Info(json);
      player.getPlayerBasicInfo(json).then(info => {
        // Get average battle per day
        basic8Info.battle += ' (' + Math.round(parseFloat(basic8Info.battle) * 100 / parseFloat(info.created)) / 100 + ')';
        // Get record
        let recordInfo = player.getRecordInfo(json);
        // Get record weapon
        let recordWeaponInfo = player.getRecordWeaponInfo(json);
        var isMain = false;
        let userInfo = global.userInfo;
        if (userInfo.id == id) isMain = true;
        this.setState({
          isReady: true,
          info: Object.assign({}, info, basic8Info),
          record: recordInfo,
          weapon: recordWeaponInfo,
          isMainAccount: isMain,
        })        
      });
    })
  }

  render() {
    if (this.state.isReady) {
      const { id, playerName } = this.props;
      const { level, created, last_battle, rank } = this.state.info;
      const { playerNameStyle, scrollViewStyle, mainViewStyle, playerInfoStyle, playerViewStyle, dontJudgeStyle } = styles;
      return (
        <View style={mainViewStyle}>
          <ScrollView style={scrollViewStyle} automaticallyAdjustContentInsets={false} contentInset={{bottom: 49}}>
            <View style={[playerViewStyle, {backgroundColor: global.themeColour}]}>
              <Text style={playerNameStyle}>{playerName}</Text>
              <Text style={playerInfoStyle}>{last_battle}</Text>
              <Text style={playerInfoStyle}>{created + ' | Lv ' + level + ' | ⭐️' + rank}</Text>
              { this.renderSetAsMainBtn() }              
            </View>
            <Basic8Cell info={this.state.info}/>
            <Text style={dontJudgeStyle}>{strings.never_judge_by_stat}</Text>
            <Divider style={{height: 1.5, backgroundColor: global.themeColour}}/>
            { this.renderRecord(this.state.record) }
            <Divider style={{height: 1.5, backgroundColor: global.themeColour}}/>
            { this.renderRecord(this.state.weapon) }
          </ScrollView>
        </View>
      )
    } else return <WoWsLoading />
  }

  renderSetAsMainBtn() {
    // If there is no main account. show this button
    const { setasmainTextStyle, setasmainViewStyle } = styles;
    const { isMainAccount } = this.state;
    if (isMainAccount) return null;
    else {
      return (
        <WoWsTouchable onPress={this.setAsMain}>
          <View style={setasmainViewStyle}>
            <Text style={setasmainTextStyle}>{strings.set_as_main}</Text>
          </View>
        </WoWsTouchable> 
      )
    }
  }

  setAsMain = () => {
    const { id, playerName, server } = this.props;    
    const { created_at } = this.state.info;
    let info = {name: playerName, id: id, server: server, created_at: created_at};
    global.userInfo = info;
    store.update(localDataName.userInfo, info);
    this.setState({
      isMainAccount: true,
    })
  }

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

export {BasicInfoScreen};