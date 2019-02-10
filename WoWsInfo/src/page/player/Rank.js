import React, { Component } from 'react';
import { View, Text, StyleSheet } from 'react-native';
import { WoWsInfo, SectionTitle, Touchable, DetailedInfo, Info6Icon, Space } from '../../component';
import lang from '../../value/lang';
import { FlatGrid } from 'react-native-super-grid';
import { Headline, Title } from 'react-native-paper';
import { SafeAction, SafeFetch } from '../../core';
import { WoWsAPI } from '../../value/api';

class Rank extends Component {
  constructor(props) {
    super(props);
    let rank = [];
    for (let key in props.data) {
      let curr = props.data[key];
      if (curr.rank_info.rank === 0) continue;
      curr.season = Number(key);
      rank.push(curr);
    }
    rank.reverse();

    this.state = {
      data: rank,
      ship: props.ship
    };

    // Request ship info
    // this.domain = 
    // SafeFetch.get(WoWsAPI.RankShipInfo, )
  }

  render() {
    const { centerText } = styles;
    const { data, ship } = this.state;
    if (data == null || data.length == 0) return null;

    console.log(data);
    return (
      <WoWsInfo title={`${lang.tab_rank_title} - ${data.length}`}>
        <FlatGrid itemDimension={300} items={data} renderItem={({item}) => {
          const { season, rank_info, rank_solo } = item;
          const { rank } = rank_info;
          const shipData = ship[season];
          return (
            <Touchable onPress={shipData == null ? null : () => SafeAction('PlayerShip', {data: shipData})}>
              <Headline style={centerText}>{`- ${lang.rank_season_title} ${season} -`}</Headline>
              <Title style={centerText}>{`${lang.tab_rank_title} ${rank}`}</Title>
                { rank > 0 ? <View>
                  { this.renderSeasonInfo(rank_solo) }
                </View> : null }
              <Space height={16}/>
            </Touchable>
          )
        }} spacing={0}/>
      </WoWsInfo>
    )
  };

  renderSeasonInfo(data) {
    if (data == null) return null;
    return <Info6Icon data={data} compact/>
  }
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    paddingBottom: 8,
    justifyContent: 'space-between',
  },
  centerText: {
    alignSelf: 'center',
    textAlign: 'center'
  }
});

export { Rank };
