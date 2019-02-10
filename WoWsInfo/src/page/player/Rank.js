import React, { Component } from 'react';
import { View, Text, StyleSheet } from 'react-native';
import { WoWsInfo, SectionTitle, Touchable, DetailedInfo, Info6Icon } from '../../component';
import lang from '../../value/lang';
import { FlatGrid } from 'react-native-super-grid';
import { Headline } from 'react-native-paper';
import { SafeAction } from '../../core';

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
      data: rank
    };
  }

  render() {
    const { container } = styles;
    const { data } = this.state;
    if (data == null || data.length == 0) return null;

    console.log(data);
    return (
      <WoWsInfo title={`${lang.tab_rank_title} - ${data.length}`}>
        <FlatGrid itemDimension={300} items={data} renderItem={({item}) => {
          const { rank } = item.rank_info;
          return (
            <View>
              <SectionTitle style={{width: '100%', textAlign: 'center'}} back center 
                title={`- ${lang.rank_season_title} ${item.season} -\n${lang.tab_rank_title} ${rank}`}/>
              <Touchable style={container} onPress={() => SafeAction('PlayerShip', {data: null})}>
                { rank > 0 ? <View>
                  { this.renderSeasonInfo(item.rank_solo) }
                </View> : null }
              </Touchable>
            </View>
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
});

export { Rank };
