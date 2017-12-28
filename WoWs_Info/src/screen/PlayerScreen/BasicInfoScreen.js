import React from 'react';
import { Basic8Cell, WoWsLoading } from '../../component';
import { View, ScrollView, Text } from 'react-native';
import { Divider } from 'react-native-elements';
import { WoWsTouchable, RecordCell } from '../../component';
import { PlayerInfo } from '../../core';
import { styles } from './BasicInfoScreenStyles';
import strings from '../../localization';

class BasicInfoScreen extends React.PureComponent {
  constructor(props) {
    super();
    this.state = {
      isReady: false,
      info: {},
      record: [],
    }
  }

  componentWillMount() {
    // Get data here
    const { id, playerName } = this.props;   
    let player = new PlayerInfo(playerName + '|' + id + '|' + global.server);
    player.Search().then(json => {
      let basic8Info = player.getBasic8Info(json);
      player.getPlayerBasicInfo(json).then(info => {
        // Get average battle per day
        basic8Info.battle += ' (' + Math.round(parseFloat(basic8Info.battle) * 100 / parseFloat(info.created)) / 100 + ')';
        // Get record
        let recordInfo = player.getRecordInfo(json);
        this.setState({
          isReady: true,
          info: Object.assign({}, info, basic8Info),
          record: recordInfo,
        })        
      });
    })
  }

  render() {
    if (this.state.isReady) {
      const { id, playerName } = this.props;
      const { level, created } = this.state.info;
      const { playerNameStyle, scrollViewStyle, mainViewStyle, playerInfoStyle, playerViewStyle} = styles;
      return (
        <View style={mainViewStyle}>
          <ScrollView containerStyle={scrollViewStyle} contentInset={{bottom: 50}}>
            <View style={[playerViewStyle, {backgroundColor: global.themeColour}]}>
              <Text style={playerNameStyle}>{playerName}</Text>
              { this.renderSetAsMainBtn() }    
              <Text style={playerInfoStyle}>{created + ' | Lv ' + level}</Text>
            </View>
            <Basic8Cell info={this.state.info}/>
            <Divider style={{height: 1.5, backgroundColor: global.themeColour}}/>
            { this.renderRecord() }
          </ScrollView>
        </View>
      )
    } else return <WoWsLoading />
  }

  renderSetAsMainBtn() {
    // If there is no main account. show this button
    const { setasmainTextStyle, setasmainViewStyle } = styles;
    return (
      <WoWsTouchable>
        <View style={setasmainViewStyle}>
          <Text style={setasmainTextStyle}>{strings.set_as_main}</Text>
        </View>
      </WoWsTouchable> 
    )
  }

  renderRecord() {
    return this.state.record.map((data, i) => {
      return (
        <View key={i}>
          <RecordCell info={data}/>          
        </View>
      )
    })
  }

}

export {BasicInfoScreen};