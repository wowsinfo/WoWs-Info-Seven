import React, { PureComponent } from 'react'
import { View, Text } from 'react-native-animatable';
import { TextInput, Picker, StyleSheet, SafeAreaView } from 'react-native';
import GridView from 'react-native-super-grid';
import { WoWsLoading, WoWsTouchable } from '../component';
import language from '../constant/language';
import store from 'react-native-simple-store';
import { LocalData } from '../constant/value';
import { PlayerSearch } from '../core';
import { GREY } from 'react-native-material-color';

export default class Search extends PureComponent {
  constructor(props) {
    super();
    props.navigator.setOnNavigatorEvent(this.onNavigatorEvent.bind(this));
    this.state = {
      mode: 0, server: server, showPicker: true, data: [], input: ''
    }
  }

  onNavigatorEvent(event) {
    if (event.type == 'NavBarButtonPress') {
      if (event.id == 'drawer') {
       
      }
    }
  }

  render() {
    const { showPicker, data, input } = this.state;
    const { inputStyle, textStyle } = styles;
    return (
      <View style={{flex: 1, padding: 8}} animation='slideInDown'>
        <TextInput style={inputStyle} underlineColorAndroid='white' onEndEditing={this.search} autoCorrect={false}
          onChangeText={(text) => this.setState({input: text})} autoCapitalize='none' value={input}/>
        { showPicker ? this.renderPicker() : null }
        <GridView itemDimension={256} items={data} renderItem={item => {
          return (
            <WoWsTouchable>
              <SafeAreaView style={{height: 44, justifyContent: 'center'}}>
                <Text animation='flipInX' style={textStyle}>{'[' + item.id + '] ' + item.name}</Text>                          
              </SafeAreaView>
            </WoWsTouchable>
          )}} showsVerticalScrollIndicator={false}/>
      </View>
    )
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
        if (data != undefined) this.setState({data: data, showPicker: false})
      })
    } else {
      // Clan
    }
  }

  /**
   * Render picker for selecting mode and server
   */
  renderPicker = () => {
    const { pickerViewStyle, pickerStyle } = styles;
    const { server, mode } = this.state;
    return (
      <View style={pickerViewStyle}>
        <Picker selectedValue={server} style={pickerStyle} mode='dropdown'
          onValueChange={(value, index) => {
            this.setState({server: value});
            global.server = value; // Update server
            store.save(LocalData.server, value);
          }}>
          <Picker.Item label={language.server_russia.toUpperCase()} value={0}/>
          <Picker.Item label={language.server_europe.toUpperCase()} value={1}/>
          <Picker.Item label={language.server_na.toUpperCase()} value={2}/>
          <Picker.Item label={language.server_asia.toUpperCase()} value={3}/>
        </Picker>
        <Picker selectedValue={mode} style={pickerStyle} mode='dropdown'
          onValueChange={(value, index) => this.setState({mode: value})}>
          <Picker.Item label={language.search_player} value={0}/>
          <Picker.Item label={language.search_clan} value={1}/>
        </Picker>
      </View>
    )
  }
}

const styles = StyleSheet.create({
  pickerViewStyle: {
    flex: 1, flexDirection: 'row', padding: 4,
    height: 50
  },
  pickerStyle: {
    height: 40, flex: 1
  },
  inputStyle: {
    borderRadius: 8, elevation: 1,
    textAlign: 'center', fontSize: 18,
    height: android ? 46 : 36,
    borderWidth: android ? 0 : 1,
    borderColor: GREY[300]
  },
  textStyle: {
    fontSize: 16, fontWeight: '300',
    color: GREY[900]
  }
})