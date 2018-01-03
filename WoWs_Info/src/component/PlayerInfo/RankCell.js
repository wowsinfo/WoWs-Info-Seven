import React from 'react';
import { View, Text } from 'react-native';
import { Rating } from 'react-native-elements';
import { Info3Cell, WoWsTouchable } from '../../component';
import { Actions } from 'react-native-router-flux';
import { RankInfo } from '../../core';
import strings from '../../localization';
import { styles } from './RankCellStyles';

class RankCell extends React.PureComponent {
  render() {
    return (
      <View style={[mainViewStyle, {borderColor: global.themeColour}]}>
        <WoWsTouchable onPress={this.gotoDetail}>
          <View>
            { this.renderRankInfo() }
            { this.renderInfo3Cell() }
          </View>
        </WoWsTouchable>
      </View>
    )
  }

  renderRankInfo() {
    const { season } = this.props.rank;
    const { rank, stars } = this.props.rank.rank_info;
    return (
      <View style={rankViewStyle}>
        <Text style={seasonStyle}>{strings.season + season}</Text>
        <Text style={[rankStyle, {color: global.themeColour}]}>{rank}</Text>        
        <Rating startingValue={stars} ratingCount={this.getStarCount(rank)} imageSize={40} type='heart' style={ratingStyle}/>
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
    const { ship, rank } = this.props;
    var rankDetail = [];
    for (var i = 0; i < ship.length; i++) {
      let curr = ship[i];
      if (curr.season == rank.season) rankDetail.push(curr);
    }
    Actions.RankDetailScreen({title: strings.season + rank.season, ship: rankDetail});
  }
}

const { mainViewStyle, rankViewStyle, rankStyle, seasonStyle, ratingStyle } = styles;

export {RankCell};