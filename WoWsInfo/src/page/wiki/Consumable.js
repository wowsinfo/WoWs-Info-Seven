/**
 * Consumable.js
 * 
 * Display flag and camouflage or upgrade.
 * There are two modes for this page
 */

import React, { Component } from 'react';
import { SafeAreaView, Image, StyleSheet } from 'react-native';
import GridView from 'react-native-super-grid';
import { Surface } from 'react-native-paper';
import { BackButton, LoadingModal } from '../../component';
import { SAVED } from '../../value/data';

class Consumable extends Component {
  constructor(props) {
    super(props);

    // Load data depending on 'upgrade' prop
    let data = [];
    let consumable = DATA[SAVED.consumable];
    for (let key in consumable) {
      let curr = consumable[key];
      if (curr.type === 'Modernization') {
        data.push(curr);
      }
    }

    // Sort by price
    data.sort((a, b) => {
      if (a.price_gold === 0) {
        return a.price_credit - b.price_credit;
      } else {
        return a.price_gold - b.price_gold;
      }
    })

    this.state = {
      data: data
    }
  }

  render() {
    const { container } = styles;

    return (
      <Surface style={container}>
        <SafeAreaView>
          { this.renderGrid() }
          <BackButton />
        </SafeAreaView>
      </Surface>
    )
  };

  renderGrid() {
    const { data } = this.state;
    if (!data) return <LoadingModal />;

    return (
      <GridView itemDimension={64} items={data} renderItem={item => {
        return <Image source={{uri: item.image}} style={{height: 64, width: 64}} />
      }}/>
    )
  }
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    alignItems: 'center',
    justifyContent: 'center'
  }
});

export { Consumable };
