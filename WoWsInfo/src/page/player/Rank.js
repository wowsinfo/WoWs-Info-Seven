import React, { Component } from 'react';
import { View, Text, StyleSheet } from 'react-native';
import { WoWsInfo } from '../../component';

class Rank extends Component {
  render() {
    const { container } = styles;
    const { data } = this.props;
    console.log(data);
    return (
      <WoWsInfo>

      </WoWsInfo>
    )
  };
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    alignItems: 'center',
    justifyContent: 'center'
  }
});

export { Rank };
