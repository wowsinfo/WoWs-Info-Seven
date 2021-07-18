import React, {PureComponent} from 'react';
import {View, StyleSheet} from 'react-native';
import {WoWsInfo, Touchable, Info6Icon} from '../../component';
import {lang} from '../../value/lang';
import {FlatGrid} from 'react-native-super-grid';
import {Headline, Title} from 'react-native-paper';
import {SafeAction} from '../../core';

class Rank extends PureComponent {
  constructor(props) {
    super(props);
    let list = [];
    for (let key in props.data) {
      let curr = props.data[key];
      const {rank, start_rank} = curr.rank_info;
      if (rank === 0 || rank === start_rank) continue;
      curr.season = Number(key);
      list.push(curr);
    }
    list.reverse();

    this.state = {
      data: list,
      ship: props.ship,
    };

    // Request ship info
    // this.domain =
    // SafeFetch.get(WoWsAPI.RankShipInfo, )
  }

  render() {
    const {centerText} = styles;
    const {data, ship} = this.state;
    if (data == null || data.length == 0) return null;

    console.log(data);
    return (
      <WoWsInfo title={`${lang.tab_rank_title} - ${data.length}`}>
        <FlatGrid
          itemDimension={300}
          data={data}
          renderItem={({item}) => {
            const {season, rank_info} = item;
            const {rank, start_rank} = rank_info;
            const shipData = ship[season];

            let emoji = '⭐';

            return (
              <Touchable
                onPress={
                  shipData == null
                    ? null
                    : () => SafeAction('PlayerShip', {data: shipData})
                }
                style={{margin: 8}}>
                <Headline
                  style={
                    centerText
                  }>{`- ${lang.rank_season_title} ${season} -`}</Headline>
                <Title style={centerText}>{`${emoji} ${rank} ${emoji}`}</Title>
                {rank > 0 && rank !== start_rank ? (
                  <View>{this.renderSeasonInfo(item)}</View>
                ) : null}
              </Touchable>
            );
          }}
          spacing={0}
        />
      </WoWsInfo>
    );
  }

  renderSeasonInfo(data) {
    if (data == null) return null;
    const {rank_solo, rank_div2, rank_div3} = data;
    let info = rank_solo;
    if (info == null) info = rank_div2;
    if (info == null) info = rank_div3;
    if (info == null) return null;
    return <Info6Icon data={info} compact topOnly />;
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
    textAlign: 'center',
  },
});

export {Rank};
