import React, { Component } from 'react';
import { View, Text, StyleSheet } from 'react-native';
import strings from '../../localization';

class NoInformation extends Component {
  render() {
    return (
      <View style={noInfoViewStyle}>
        <Text style={noInfoTextStyle}>{strings.no_info}</Text>
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
const { noInfoTextStyle, noInfoViewStyle } = styles;

export {NoInformation};