import React, { Component } from 'react';
import { View, Text, StyleSheet } from 'react-native';
import language from '../../constant/language';

class NoInformation extends Component {
  render() {
    const { noInfoTextStyle, noInfoViewStyle } = styles;    
    return (
      <View style={noInfoViewStyle}>
        <Text style={noInfoTextStyle}>{language.no_information}</Text>
      </View>
    )
  }
}

const styles = StyleSheet.create({
  noInfoViewStyle: {
    flex: 1,
    justifyContent: 'center',
  },
  noInfoTextStyle: {
    textAlign: 'center',
    fontSize: 24,
    fontWeight: '300',
    margin: 8,
  },
})

export { NoInformation };