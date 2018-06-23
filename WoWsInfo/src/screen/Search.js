import React, { PureComponent } from 'react'
import { View, Text } from 'react-native-animatable';
import { TextInput, Picker, StyleSheet, SegmentedControlIOS } from 'react-native';
import GridView from 'react-native-super-grid';
import { WoWsTouchable } from '../component';
import language from '../constant/language';
import store from 'react-native-simple-store';
import { LocalData } from '../constant/value';
import { PlayerSearch, ClanSearch } from '../core';
import { GREY } from 'react-native-material-color';
import { navStyle, getTheme } from '../constant/colour';
import { hapticFeedback } from '../app/App';
import { iconsMap } from '../constant/icon';

export default class Search extends PureComponent {
  constructor(props) {
    super();
    props.navigator.setOnNavigatorEvent(this.onNavigatorEvent.bind(this));
    this.state = {
      mode: 0, server: server, showPicker: true, 
      data: friend, input: ''
    }
  }

  onNavigatorEvent(event) {
    if (event.type == 'NavBarButtonPress') {
      if (event.id == 'reset') {
        hapticFeedback();
        this.setState({mode: 0, server: server, showPicker: true, data: friend, input: ''})
        this.refs['search'].bounceInDown(800);
      }
    } else if (event.id === 'bottomTabSelected') {
      let store = require('react-native-simple-store');
      store.save(LocalData.saved_tab, 0);
    }
  }

  render() {
    const { showPicker, data, input, mode } = this.state;
    const { inputStyle, textStyle } = styles;
    return (
      <View style={{flex: 1, padding: 4}} ref='search'>
        { showPicker ? this.renderPicker() : null }
        <TextInput style={inputStyle} underlineColorAndroid='white' onEndEditing={this.search} autoCorrect={false}
          clearButtonMode='while-editing' onChangeText={(text) => this.setState({input: text})} autoCapitalize='none' value={input}/>
        { showPicker ? this.renderMain() : null }  
        <GridView itemDimension={256} items={data} renderItem={item => {
          return (
            <WoWsTouchable onPress={() => mode == 0 ? this.pushToPlayer(item) : this.pushToClan(item)}>
              <Text style={textStyle}>{'[' + item.id + '] ' + item.name}</Text>
            </WoWsTouchable>
          )}}/>
      </View>
    )
  }

  /**
   * Push to player screen
   * @param {*} item 
   */
  pushToPlayer(item) {
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

  /**
   * Push to clan screen
   * @param {*} item 
   */
  pushToClan(item) {
    this.props.navigator.push({
      title: String(item.id),
      screen: 'search.clan',
      backButtonTitle: '',              
      navigatorStyle: navStyle(),
      passProps: item
    })
  }

  /**
   * Search player or clan
   */
  search = () => {
    const { mode, input } = this.state;
    this.setState({data: []})
    if (mode == 0) {
      // Player
      let player = new PlayerSearch(server, input);
      player.Search().then(data => {
        if (data != undefined) {
          this.setState({data: data, showPicker: false});
          this.refs['search'].bounceInUp(800);
        }
      })
    } else {
      // Clan
      let clan = new ClanSearch(server, input);
      clan.Search().then(data => {
        if (data != undefined) {
          this.setState({data: data, showPicker: false});
          this.refs['search'].bounceInUp(800);
        }
      })
    }
  }

  /**
   * Render picker for selecting mode and server
   */
  renderPicker = () => {
    const { pickerViewStyle, pickerStyle, segmentStyle } = styles;
    const { server, mode } = this.state;
    const RU = language.server_russia.toUpperCase();
    const EU = language.server_europe.toUpperCase();
    const NA = language.server_na.toUpperCase();
    const ASIA = language.server_asia.toUpperCase();
    if (android) {
      return (
        <View style={pickerViewStyle}>
          <Picker selectedValue={server} style={pickerStyle} mode='dropdown'
            onValueChange={(value, index) => {
              this.setState({server: value});
              global.server = value; // Update server
              if (value == 0) global.news_language = 'ru';
              else global.news_language = 'en';
              store.save(LocalData.server, value);
              console.log(value, index);
            }}>
            <Picker.Item label={RU} value={0}/>
            <Picker.Item label={EU} value={1}/>
            <Picker.Item label={NA} value={2}/>
            <Picker.Item label={ASIA} value={3}/>
          </Picker>
          <Picker selectedValue={mode} style={pickerStyle} mode='dropdown'
            onValueChange={(value, index) => this.setState({mode: value, data: value == 0 ? friend : []})}>
            <Picker.Item label={language.search_player} value={0}/>
            <Picker.Item label={language.search_clan} value={1}/>
          </Picker>
        </View>
      )
    } else {
      let color = getTheme();
      return (
        <View style={segmentStyle}>
          <SegmentedControlIOS values={[RU, EU, NA, ASIA]} selectedIndex={server}
            tintColor={color} onChange={(event) => {
              let value = event.nativeEvent.selectedSegmentIndex;
              this.setState({server: value});
              global.server = value; // Update server
              store.save(LocalData.server, value);
            }}/>
          <View style={{margin: 2}}></View>
          <SegmentedControlIOS values={[language.search_player, language.search_clan]} selectedIndex={mode}
            tintColor={color} onChange={(event) => this.setState({mode: event.nativeEvent.selectedSegmentIndex,  data: event.nativeEvent.selectedSegmentIndex == 0 ? friend : []})}/>
        </View>
      )
    }
  }

  /**
   * Render main account
   */
  renderMain = () => {
    const { id, name } = user_info;
    if (user_info.id == "") return null;
    else return (
      <WoWsTouchable onPress={() => this.pushToPlayer(user_info)}>
        <View style={{padding: 8}}><Text style={{fontSize: 18, fontWeight: 'bold', textAlign: 'center'}}>{name + '|' + id}</Text></View>
      </WoWsTouchable>
    )
  }
}

const styles = StyleSheet.create({
  pickerViewStyle: {
    flexDirection: 'row', padding: 4,
    height: 50
  },
  pickerStyle: {
    height: 40, flex: 1
  },
  segmentStyle: {
    paddingBottom: 8
  },
  inputStyle: {
    textAlign: 'center', fontSize: 18,
    height: android ? 46 : 36,
    borderWidth: 1,
    borderRadius: 8,
    borderColor: GREY[300]
  },
  textStyle: {
    fontSize: 16, fontWeight: '300',
    color: GREY[900], padding: 8
  }
})