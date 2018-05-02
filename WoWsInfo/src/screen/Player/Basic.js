import React, { Component } from 'react';
import { View } from 'react-native';
import { PlayerInfo } from '../../core';
import { WoWsLoading } from '../../component';

class Basic extends Component {
  constructor(props) {
    super(props);
    console.log(props);
    this.state = {
      isReady: false,
      info: {}, record: [], weapon: []
    }
  }

  componentWillMount() {
    // Get data here
    const { id, name, server } = this.props;   
    let player = new PlayerInfo(name, id, server);
    player.Search().then(json => {
      if (json == null || json == undefined) return;
      let basic8Info = player.getBasic8Info(json);
      player.getPlayerBasicInfo(json).then(info => {
        if (info == null || info == undefined) return;        
        // Get average battle per day
        basic8Info.battle += ' (' + Math.round(parseFloat(basic8Info.battle) * 100 / parseFloat(info.created)) / 100 + ')';
        // Get record
        let recordInfo = player.getRecordInfo(json);
        // Get record weapon
        let recordWeaponInfo = player.getRecordWeaponInfo(json);
        this.setState({
          isReady: true,
          info: Object.assign({}, info, basic8Info),
          record: recordInfo, weapon: recordWeaponInfo
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
        <SafeAreaView style={mainViewStyle}>
          <ScrollView style={scrollViewStyle} automaticallyAdjustContentInsets={false}>
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
        </SafeAreaView>
      )
    } else return <WoWsLoading />
  }
}

export { Basic };