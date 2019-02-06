import React, { Component } from 'react';
import { View, Text, StyleSheet } from 'react-native';
import { SAVED } from '../../value/data';
import { WoWsInfo, WikiIcon, Touchable } from '../../component';
import { FlatGrid } from 'react-native-super-grid';
import { Paragraph } from 'react-native-paper';
import { SafeAction } from '../../core';
import lang from '../../value/lang';

class PlayerAchievement extends Component {
  constructor(props) {
    super(props);

    let saved = DATA[SAVED.achievement];
    let data = props.data;

    let formatted = [];
    for (let key in data) {
      let obj = saved[key];
      if (obj != null) {
        formatted.push({data: obj, num: data[key]});
      }
    }

    formatted.sort((a, b) => b.num - a.num);
    this.state = {
      data: formatted
    };
  }

  render() {
    const { number } = styles;
    const { data } = this.state;
    return (
      <WoWsInfo title={`${lang.tab_achievement_title} - ${data.length}`}>
        <FlatGrid itemDimension={80} items={data} renderItem={({item}) => {
          return (
            <Touchable onPress={() => SafeAction('BasicDetail', {item: item.data})}>
              <WikiIcon item={item.data} />
              <Paragraph style={number}>{item.num}</Paragraph>
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
  },
  number: {
    textAlign: 'center'
  }
});

export { PlayerAchievement };
