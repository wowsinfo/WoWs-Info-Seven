/**
 * SimpleRating.js
 * 
 * 
 */

import React, { PureComponent } from 'react';
import { View, StyleSheet, Image } from 'react-native';
import { Text } from 'react-native-paper';
import { getColour, roundTo } from '../../core';
import { TintColour } from '../../value/colour';

class SimpleRating extends PureComponent {
  render() {
    const { centerText, horizontal, centerView } = styles;
    const { pvp, rating } = this.props.info;
    const { battles, wins, damage_dealt } = pvp;

    let nothing = false;
    if (battles === 0) nothing = true;
    
    let iconStyle = {height: 24, width: 24, tintColor: TintColour()[500]};
    return (
      <View>
        <View style={horizontal}>
          <View style={centerView}>
            <Image style={iconStyle} source={require('../../img/Battle.png')}/>
            <Text style={centerText}>{nothing ? '0' : battles}</Text>
          </View>
          <View style={centerView}>
            <Image style={iconStyle} source={require('../../img/WinRate.png')}/>
            <Text style={centerText}>{nothing ? '0.0%' : `${roundTo(wins / battles * 100, 2)}%`}</Text>
          </View>
          <View style={centerView}>
            <Image style={iconStyle} source={require('../../img/Damage.png')}/>
            <Text style={centerText}>{nothing ? '0' : roundTo(damage_dealt / battles)}</Text>
          </View>
        </View>
        <View style={{backgroundColor: getColour(rating), height: 12, borderRadius: 99}}/>
      </View>
    );
  };
}

const styles = StyleSheet.create({
  horizontal: {
    flexDirection: 'row',
    justifyContent: 'space-around',
  },
  centerText: {
    alignSelf: 'center',
  },
  centerView: {
    alignItems: 'center',
    justifyContent: 'center',
  }
});

export { SimpleRating };
