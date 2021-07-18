import React, {Component} from 'react';
import {View, ScrollView, StyleSheet} from 'react-native';
import {
  WoWsInfo,
  WarshipCell,
  InfoLabel,
  DetailedInfo,
  RatingButton,
} from '../../component';
import {SAVED} from '../../value/data';
import {Actions} from 'react-native-router-flux';
import {SafeAction, roundTo} from '../../core';
import {lang} from '../../value/lang';

class Detailed extends Component {
  constructor(props) {
    super(props);
    console.log(props.data);
    this.state = {
      data: props.data,
    };
  }

  render() {
    const {data} = this.state;
    if (data == null) {
      Actions.pop();
      return null;
    }

    const {pvp, ship_id, rating} = data;
    const ship = DATA[SAVED.warship][ship_id];
    const overall = DATA[SAVED.pr][ship_id];
    return (
      <WoWsInfo
        onPress={
          ship == null ? null : () => SafeAction('WarshipDetail', {item: ship})
        }
        title={lang.wiki_section_title}>
        <ScrollView
          contentContainerStyle={{paddingBottom: 16, paddingTop: 16}}
          showsVerticalScrollIndicator={false}>
          <WarshipCell item={ship} scale={3} />
          {this.renderNumberDiff(pvp, overall)}
          <RatingButton rating={rating} />
          <DetailedInfo data={data} />
        </ScrollView>
      </WoWsInfo>
    );
  }

  renderNumberDiff(data, overall) {
    if (overall == null || data == null) return null;
    const {horizontal} = styles;
    const {battles, wins, damage_dealt, frags} = data;
    const {average_damage_dealt, average_frags, win_rate} = overall;

    let dmgDiff = this.normalise(
      damage_dealt / battles - average_damage_dealt,
      0,
    );
    let winrateDiff = this.normalise((wins / battles) * 100 - win_rate, 2);
    let fragDiff = this.normalise(frags / battles - average_frags, 2);

    return (
      <View style={horizontal}>
        <InfoLabel
          style={this.getColor(dmgDiff)}
          info={dmgDiff}
          title={lang.ship_detail_damage}
        />
        <InfoLabel
          style={this.getColor(winrateDiff)}
          info={`${winrateDiff}%`}
          title={lang.ship_detail_winrate}
        />
        <InfoLabel
          style={this.getColor(fragDiff)}
          info={fragDiff}
          title={lang.ship_detail_frag}
        />
      </View>
    );
  }

  getColor = diff => {
    if (diff === 0) return null;
    return {color: diff > 0 ? 'green' : 'red'};
  };

  normalise = (diff, digit) => {
    let rounded = roundTo(diff, digit);
    if (rounded <= 0) return rounded;
    else return `+${rounded}`;
  };
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    alignItems: 'center',
    justifyContent: 'center',
  },
  horizontal: {
    flexDirection: 'row',
    justifyContent: 'space-around',
  },
});

export {Detailed};
