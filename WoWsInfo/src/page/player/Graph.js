import React, { Component } from 'react';
import { View, Text, StyleSheet } from 'react-native';
import { VictoryBar } from "victory-native";
import { WoWsInfo } from '../../component';

class Graph extends Component {
  render() {
    const { container } = styles;
    return (
      <WoWsInfo>
        <VictoryBar />
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

export { Graph };
