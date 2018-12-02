/**
 * Collection.js
 * 
 * 
 */

import React, { Component } from 'react';
import { View, Text, StyleSheet } from 'react-native';
import { WoWsInfo } from '../../component';
import { SAVED } from '../../value/data';

class Collection extends Component {
  constructor(props) {
    super(props);

    console.log('WIKI - Collection');
    let collection = [];
    if (props.all) {
      collection = DATA[SAVED.collection].collection;
    } else {
      collection = DATA[SAVED.collection]
    }
  }

  render() {
    const { container } = styles;
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

export { Collection };
