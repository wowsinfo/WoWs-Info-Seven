/**
 * Achievement.js
 * 
 * 
 */

import React, { Component } from 'react';
import { View, Text, StyleSheet } from 'react-native';
import GridView from 'react-native-super-grid';
import { SafeView, WikiIcon, WoWsInfo } from '../../component';
import { SAVED } from '../../value/data';
import { Actions } from 'react-native-router-flux';

class Achievement extends Component {
  constructor(props) {
    super(props);

    console.log('WIKI - Achievement');
    let achievement = DATA[SAVED.achievement];
    let sorted = Object.entries(achievement).sort((a, b) => {
      // Sort by hidden then by key
      if (a[1].hidden === b[1].hidden) return a[0].localeCompare(b[0]);
      else return a[1].hidden - b[1].hidden;
    });

    sorted.forEach((item, index) => {
      // Make it an object
      sorted[index] = Object.assign(item[1]);
    });
    console.log(sorted);

    this.state = {
      data: sorted
    };
  }

  render() {
    const { data } = this.state;
    return (
      <WoWsInfo>
        <GridView itemDimension={64} items={data} renderItem={item => {
          return <WikiIcon item={item} onPress={() => Actions.push('BasicDetail', {item: item})}/>
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

export { Achievement };
