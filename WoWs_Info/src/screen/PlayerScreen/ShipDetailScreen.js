import React from 'react';
import { View, Text, Image, ScrollView } from 'react-native';
import { PersonalRating } from '../../core';
import { styles } from './ShipDetailScreenStyles';
import { Basic8Cell } from '../../component';

class ShipDetailScreen extends React.PureComponent {
  render() {
    const { mainViewStyle, scrollViewStyle, imageStyle, shipNameStyle, ratingStyle } = styles;
    const { index, pr, ship_id, } = this.props.info;
    let shipColour = PersonalRating.getColour(index);
    let shipComment = PersonalRating.getComment(index);
    let shipInfo = this.getShipInfo(ship_id);
    return (
      <View style={mainViewStyle}>
        <ScrollView contentContainerStyle={scrollViewStyle}>
          <Image source={{uri: shipInfo.image}} style={imageStyle}/>
          <Text style={shipNameStyle}>{shipInfo.name}</Text>
          <Text style={[ratingStyle, {color: shipColour}]}>{shipComment + ' ' + Math.round(pr)}</Text>
          <Basic8Cell info={this.getBasic8CellInfo(this.props.info)}/>
        </ScrollView>
      </View>
    )
  }

  getShipInfo(id) {
    let ship = global.warshipJson[id];
    var shipInfo = {};
    shipInfo.name = ship.name;
    shipInfo.image = ship.images.small;
    return shipInfo;
  }

  getBasic8CellInfo(info) {
    var basicInfo = {};
    let battle = info.battle
    basicInfo.battle = battle;
    basicInfo.winrate = info.win_rate;
    basicInfo.damage = info.avg_damage;
    basicInfo.exp = Math.round(info.pvp.xp / battle);
    basicInfo.hitratio = Math.round(info.pvp.main_battery.hits * 10000 / info.pvp.main_battery.shots) / 100;
    basicInfo.survival = Math.round(info.pvp.survived_battles * 10000 / battle) / 100;
    let death = battle - info.pvp.survived_battles;
    basicInfo.killdeath = Math.round(info.pvp.frags * 100 / death) / 100;
    basicInfo.frag = Math.round(info.pvp.frags * 100 / battle) / 100;
    return basicInfo;
  }
}

export {ShipDetailScreen};