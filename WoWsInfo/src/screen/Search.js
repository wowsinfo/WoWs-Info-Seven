import React, { Component } from 'react'
import * as Animatable from 'react-native-animatable';
import { View, Text, TextInput, Picker, StyleSheet } from 'react-native';
import { WoWsLoading } from '../component';
import language from '../constant/language';
import store from 'react-native-simple-store';
import { LocalData } from '../constant/value';

export default class Search extends Component {
  constructor(props) {
    super();
    props.navigator.setOnNavigatorEvent(this.onNavigatorEvent.bind(this));
    this.state = {
      mode: 0, server: server, showPicker: true
    }
  }

  onNavigatorEvent(event) {
    if (event.type == 'NavBarButtonPress') {
      if (event.id == 'drawer') {
       
      }
    }
  }

  render() {
    const { showPicker } = this.state;
    const { inputStyle } = styles;
    return (
      <Animatable.View style={{flex: 1, padding: 8}} animation='slideInDown'>
        <TextInput style={inputStyle} underlineColorAndroid='white'/>
        { showPicker ? this.renderPicker() : null }
      </Animatable.View>
    )
  }

  /**
   * Search player or clan
   */
  search = () => {

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
    flex: 1, flexDirection: 'row', padding: 4
  },
  pickerStyle: {
    height: 40, flex: 1
  },
  inputStyle: {
    borderRadius: 8, elevation: 2
  }
})