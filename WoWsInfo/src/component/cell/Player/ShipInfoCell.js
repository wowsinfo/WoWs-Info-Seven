import React, { Component } from 'react';
import { View, Text, Image, StyleSheet } from 'react-native';
import { WoWsTouchable } from '../../../component';
import { PersonalRating } from '../../../core';
import { Info3Cell } from './Info3Cell';
import { getTheme } from '../../../constant/colour';
import { getImage } from '../../../constant/icon';
import language from '../../../constant/language';
import { Green, Red } from 'react-native-material-color';

class ShipInfoCell extends Component {
  render() {
    const { info, detail } = this.props;
    const { ship_id, battles, avg_damage, win_rate, index, ap } = info;
    const { mainViewStyle, subViewStyle, imageStyle, textStyle, apStyle } = styles;
    let tierList = ['I', 'II', 'III', 'IV', 'V', 'VI', 'VII', 'VIII', 'IX', 'X'];
    let shipInfo = this.getShipInfo(ship_id);
    let shipColour = PersonalRating.getColour(index);
    let shipType = getImage(shipInfo.type);
    var name = shipInfo.name; if (name == undefined) name = language.player_deleted_ship;
    // For real time stat
    if (info.name) name = `${name}|${info.name} `
    var tier = tierList[shipInfo.tier - 1]; if (tier == undefined) tier = 'XI';
    this.tierName = tier + ' ' + name;
    var color = getTheme();
    // Red for enemy, green for friends
    let relation = info.relation;
    if (relation) {
      color = relation < 2 ? Green : Red;
    }       
    return (
      <WoWsTouchable onPress={() => detail(this.props.info)}>
        <View style={[mainViewStyle, {borderColor: shipColour}]}>
          <View style={subViewStyle}>
            <Image resizeMode='contain' source={shipType} style={[imageStyle, {tintColor: color}]}/>
            <Text style={textStyle}>{this.tierName}</Text>
            <Text style={apStyle}>{'(' + ap + ')'}</Text>
          </View>
          <Info3Cell info={{battle: battles, winrate: win_rate, damage: avg_damage}}/>
        </View>
      </WoWsTouchable>
    )
  }

  /**
   * Get basic ship information∂
   * @param {*} id 
   */
  getShipInfo(id) {
    let shipInfo = {};    
    let ship = data.warship[id];
    if (ship != null) {
      const { name, icon, type, tier, nation } = ship;
      shipInfo.name = name;
      shipInfo.image = icon;
      shipInfo.type = type;
      shipInfo.tier = tier;
      shipInfo.nation = nation;
    }
    return shipInfo;    
  }
}

const styles = StyleSheet.create({
  mainViewStyle: {
    borderWidth: 1.75,
    borderRadius: 8,
    padding: 2
  },
  subViewStyle: {
    flex: 1,
    flexDirection: 'row',
    padding: 4,
    alignItems: 'center',
  },
  imageStyle: {
    width: 30,
    height: 13.6,
    marginRight: 4,
  },
  apStyle: {
    fontSize: 16, fontWeight: '300',
    marginLeft: 4,    
  },
  textStyle: {
    marginLeft: 8,
    fontSize: 16,
  }
})

export { ShipInfoCell };