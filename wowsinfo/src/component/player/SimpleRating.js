/**
 * SimpleRating.js
 *
 * Rating and class 3 icons
 */

import React, {PureComponent} from 'react';
import {View, StyleSheet, Image} from 'react-native';
import {Text} from 'react-native-paper';
import {getColour, roundTo} from '../../core';
import {TintColour} from '../../value/colour';

class SimpleRating extends PureComponent {
  render() {
    const {centerText, horizontal, centerView} = styles;
    const {pvp, rating} = this.props.info;

    let nothing = false;
    if (pvp == null) nothing = true;
    else if (pvp.battles === 0) nothing = true;

    let iconStyle = {height: 24, width: 24, tintColor: TintColour()[500]};
    return (
      <View>
        <View style={horizontal}>
          <View style={centerView}>
            <Image style={iconStyle} source={require('../../img/Battle.png')} />
            <Text style={centerText}>{nothing ? '0' : pvp.battles}</Text>
          </View>
          <View style={centerView}>
            <Image
              style={iconStyle}
              source={require('../../img/WinRate.png')}
            />
            <Text style={centerText}>
              {nothing
                ? '0.0%'
                : `${roundTo((pvp.wins / pvp.battles) * 100, 2)}%`}
            </Text>
          </View>
          <View style={centerView}>
            <Image style={iconStyle} source={require('../../img/Damage.png')} />
            <Text style={centerText}>
              {nothing ? '0' : roundTo(pvp.damage_dealt / pvp.battles)}
            </Text>
          </View>
        </View>
        <View
          style={{
            backgroundColor: getColour(rating),
            height: 12,
            borderRadius: 99,
          }}
        />
      </View>
    );
  }
}

const styles = StyleSheet.create({
  horizontal: {
    flexDirection: 'row',
    justifyContent: 'space-around',
  },
  centerText: {
    alignSelf: 'center',
    fontSize: 13,
    fontWeight: '300',
  },
  centerView: {
    alignItems: 'center',
    justifyContent: 'center',
  },
});

export {SimpleRating};
