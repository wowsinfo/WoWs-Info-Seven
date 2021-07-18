/**
 * Achievement.js
 *
 * This is the wiki achievements
 */

import React, {PureComponent} from 'react';
import {StyleSheet} from 'react-native';
import {FlatGrid} from 'react-native-super-grid';
import {WikiIcon, WoWsInfo} from '../../component';
import {SAVED, setLastLocation} from '../../value/data';
import {SafeAction} from '../../core';

class Achievement extends PureComponent {
  constructor(props) {
    super(props);
    setLastLocation('Achievement');
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
      data: sorted,
    };
  }

  render() {
    const {data} = this.state;
    return (
      <WoWsInfo>
        <FlatGrid
          itemDimension={80}
          data={data}
          renderItem={({item}) => {
            return (
              <WikiIcon
                item={item}
                onPress={() => SafeAction('BasicDetail', {item: item})}
              />
            );
          }}
          showsVerticalScrollIndicator={false}
        />
      </WoWsInfo>
    );
  }
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    alignItems: 'center',
    justifyContent: 'center',
  },
});

export {Achievement};
