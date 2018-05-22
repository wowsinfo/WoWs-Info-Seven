import React, { Component } from 'react';
import { View, Text, StyleSheet } from 'react-native';
import { Rating } from 'react-native-elements';
import ElevatedView from 'react-native-elevated-view';
import { Info3Cell, WoWsTouchable } from '../../../component';
import { RankInfo } from '../../../core';
import { getTheme } from '../../../constant/colour';
import language from '../../../constant/language';
import { Red } from 'react-native-material-color';

class RankCell extends Component {
  render() {
    return (
      <ElevatedView elevation={2} style={styles.mainViewStyle}>
        <WoWsTouchable onPress={this.gotoDetail}>
            { this.renderRankInfo() }
            { this.renderInfo3Cell() }
        </WoWsTouchable>
      </ElevatedView>
    )
  }

  renderRankInfo() {
    const { season } = this.props.rank;
    const { rank, stars } = this.props.rank.rank_info;
    const { mainViewStyle, rankViewStyle, rankStyle, seasonStyle, ratingStyle } = styles;    
    return (
      <View style={rankViewStyle}>
        <Text style={seasonStyle}>{language.rank_season + season}</Text>
        <Text style={[rankStyle, {color: getTheme()}]}>{rank}</Text>        
        <Rating startingValue={stars} ratingCount={this.getStarCount(rank)} readonly
          imageSize={40} type={theme[500] == Red ? 'heart' : 'star'} style={ratingStyle}/>
      </View>
    )    
  }

  getStarCount(rank) {
    if (rank > 22) return 1;
    if (rank > 15) return 2;
    if (rank > 10) return 3;
    if (rank > 5) return 4;
    if (rank > 1) return 5;
    return 1;
  }

  renderInfo3Cell() {
    const { battles, wins, damage_dealt } = this.props.rank.rank_solo;
    let info = {battle: battles, winrate: Math.round(wins * 10000 / battles) / 100, damage: Math.round(damage_dealt / battles)};
    return <Info3Cell info={info}/>
  }

  gotoDetail = () => {
    const { ship, rank, detail } = this.props;
    var rankDetail = [];
    for (var i = 0; i < ship.length; i++) {
      const { season } = ship[i];
      if (season == rank.season) rankDetail.push(ship[i]);
    }
    rankDetail.season = rank.season;
    detail(rankDetail);
  }
}

const styles = StyleSheet.create({
  mainViewStyle: {
    padding: 4,
    marginBottom: 4,
  },
  rankViewStyle: {
    alignItems: 'center',
  },
  seasonStyle: {
    textAlign: 'center',
    fontSize: 20,
    fontWeight: '300',
  },
  rankStyle: {
    textAlign: 'center',
    fontSize: 64,
  },
  ratingStyle: {
    marginBottom: 16,
  }
})

export { RankCell };