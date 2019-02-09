import React, { Component } from 'react';
import { View, StyleSheet } from 'react-native';
import { WoWsInfo, WarshipCell, Touchable } from '../../component';
import { getOverallRating, roundTo } from '../../core';
import { FlatGrid } from 'react-native-super-grid';
import { SAVED } from '../../value/data';
import { Text } from 'react-native-paper';

class PlayerShip extends Component {
  constructor(props) {
    super(props);

    let ships = props.data;
    console.log(ships);
    ships.sort((a, b) => a.ap - b.ap);

    this.state = {
      data: ships
    };
  }

  render() {
    const { container } = styles;
    const { data } = this.state;
    return (
      <WoWsInfo>
        <FlatGrid itemDimension={150} items={data} renderItem={({item}) => {
          let ship = DATA[SAVED.warship][item.ship_id];
          const { battles, wins, frags } = item.pvp;
          let simpleStat = `${battles} - ${roundTo(wins / battles * 100, 2)}% - ${roundTo(frags / battles * 100, 2)}`;
          if (battles === 0) simpleStat = '0 - 0 - 0';
          return (
            <Touchable>
              <WarshipCell item={ship} scale={1.8}/>
              <Text>{simpleStat}</Text>
            </Touchable>
          )
        }}/>
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
