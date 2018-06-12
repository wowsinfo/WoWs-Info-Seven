import React, { PureComponent } from 'react';
import { View, Image, NetInfo, StyleSheet, Text, ActivityIndicator } from 'react-native';
import { Blue, GREY } from 'react-native-material-color';
import { DataStorage } from '../core';
import { startApp } from '../app/App';
import language from '../constant/language';

export default class WoWsInfo extends PureComponent {
  static navigatorStyle = { navBarHidden: true, tabBarHidden: true }

  state = { net: 'unknown', status: '', isFirst: true };
  render() {
    // Updating api data
    const { net, status, isFirst } = this.state;    
    if (!this.props.api && isFirst) {
      NetInfo.getConnectionInfo().then((info) => this.setState({net: info.type}));
      NetInfo.addEventListener('connectionChange', (info) => {
        if (info.type == 'none' || info.type == 'unknown') {
          this.setState({status: language.no_internet});
        } else this.setState({net: info.type});
      });
  
      console.log(net);
      if (net == 'wifi' || net == 'cellular') {
        console.log('Device is online');      
        this.setState({isFirst: false});        
        DataStorage.DataValidation(this.updateText).then(() => startApp());
      }
    }

    const { viewStyle, imageStyle, textStyle } = styles;  
    let currHour = new Date().getHours();
    return (
      <View style={[viewStyle, {backgroundColor: currHour >= 18 ? GREY[800] : Blue}]}>
        <Image style={imageStyle} source={require('../img/Logo.png')}/>
        <Text style={textStyle}>{status}</Text>        
        { net == 'unknown' ? null :  <ActivityIndicator size='large' color='white'/> }
      </View>
    )
  }

  updateText = (text) => {
    this.setState({status: text});
  }
}

const styles = StyleSheet.create({
  viewStyle: {
    backgroundColor: Blue,
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center'
  },
  imageStyle: {
    height: 128, width: 128,
    margin: 16,
  }, 
  textStyle: {
    color: 'white',
    padding: 10,
    marginBottom: 20
  }
})