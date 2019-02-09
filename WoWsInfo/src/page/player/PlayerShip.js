import React, { Component } from 'react';
import { View, Text, StyleSheet } from 'react-native';
import { WoWsInfo } from '../../component';

class PlayerShip extends Component {
  constructor(props) {
    super(props);

    console.log(props.data);
  }

  render() {
    const { container } = styles;
    return (
      <WoWsInfo>
        <Text>Ship</Text>
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

export { PlayerShip };
